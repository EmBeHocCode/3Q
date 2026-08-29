from __future__ import annotations

import argparse
import collections
import pathlib
import re
import sys
import zlib


HAN_RE = re.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")


def read_utf_string(data: bytes, offset: int) -> tuple[str, int]:
    if offset + 2 > len(data):
        raise ValueError(f"Missing UTF length at offset {offset}")
    size = int.from_bytes(data[offset : offset + 2], "big")
    end = offset + 2 + size
    if end > len(data):
        raise ValueError(f"UTF string overruns buffer at offset {offset}")
    return data[offset + 2 : end].decode("utf-8"), end


def parse_row(row: bytes) -> list[str]:
    values: list[str] = []
    offset = 0
    while offset < len(row):
        value, offset = read_utf_string(row, offset)
        values.append(value)
    return values


def parse_tables(data: bytes) -> list[tuple[str, list[list[str]]]]:
    tables: list[tuple[str, list[list[str]]]] = []
    offset = 0
    while offset < len(data):
        name, offset = read_utf_string(data, offset)
        if offset + 4 > len(data):
            raise ValueError(f"Missing row count for table {name!r}")
        row_count = int.from_bytes(data[offset : offset + 4], "big", signed=True)
        offset += 4
        rows: list[list[str]] = []
        for _ in range(row_count):
            if offset + 2 > len(data):
                raise ValueError(f"Missing row size in table {name!r}")
            row_size = int.from_bytes(data[offset : offset + 2], "big", signed=True)
            offset += 2
            if row_size < 0 or offset + row_size > len(data):
                raise ValueError(f"Invalid row size {row_size} in table {name!r}")
            rows.append(parse_row(data[offset : offset + row_size]))
            offset += row_size
        tables.append((name, rows))
    return tables


def scan_cells(data: bytes) -> collections.Counter[tuple[str, str, str]]:
    cells: collections.Counter[tuple[str, str, str]] = collections.Counter()
    for table_name, rows in parse_tables(data):
        if not rows:
            continue
        headers = rows[0]
        for row in rows[1:]:
            for index, value in enumerate(row):
                if not HAN_RE.search(value):
                    continue
                header = headers[index] if index < len(headers) else f"#{index}"
                cells[(table_name, header, value)] += 1
    return cells


def scan_prefixed_utf8(data: bytes) -> collections.Counter[str]:
    strings: collections.Counter[str] = collections.Counter()
    for offset in range(len(data) - 2):
        size = int.from_bytes(data[offset : offset + 2], "big")
        if not 1 <= size <= 2048 or offset + 2 + size > len(data):
            continue
        raw = data[offset + 2 : offset + 2 + size]
        try:
            value = raw.decode("utf-8")
        except UnicodeDecodeError:
            continue
        if HAN_RE.search(value) and all(char.isprintable() or char in "\r\n\t" for char in value):
            strings[value] += 1
    return strings


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8", errors="backslashreplace")
    parser = argparse.ArgumentParser()
    parser.add_argument("path", type=pathlib.Path)
    parser.add_argument("--limit", type=int, default=300)
    parser.add_argument("--cells", action="store_true")
    parser.add_argument("--headers", action="store_true")
    args = parser.parse_args()

    packed = args.path.read_bytes()
    data = zlib.decompress(packed)
    if args.headers:
        cells = scan_cells(data)
        headers: collections.Counter[tuple[str, str]] = collections.Counter()
        unique_values: dict[tuple[str, str], set[str]] = collections.defaultdict(set)
        for (table, header, value), count in cells.items():
            headers[(table, header)] += count
            unique_values[(table, header)].add(value)
        print(f"han_columns={len(headers)}")
        for (table, header), count in headers.most_common(args.limit):
            print(f"{count}\t{len(unique_values[(table, header)])}\t{table}\t{header}")
    elif args.cells:
        cells = scan_cells(data)
        tables = parse_tables(data)
        print(
            f"packed_bytes={len(packed)} unpacked_bytes={len(data)} "
            f"tables={len(tables)} han_cells={sum(cells.values())} unique_han_cells={len(cells)}"
        )
        for (table, header, value), count in cells.most_common(args.limit):
            print(f"{count}\t{table}\t{header}\t{value.replace(chr(10), ' ')}")
    else:
        strings = scan_prefixed_utf8(data)
        print(f"packed_bytes={len(packed)} unpacked_bytes={len(data)} unique_han_strings={len(strings)}")
        for value, count in strings.most_common(args.limit):
            print(f"{count}\t{value.replace(chr(10), ' ')}")


if __name__ == "__main__":
    main()
