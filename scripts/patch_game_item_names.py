"""Patch user-facing item names inside the compressed game template bundle."""

from __future__ import annotations

import struct
import zlib

from extract_game_catalog import SOURCE, read_tables


TABLE_ITEMS = "基础物品"
COL_ITEM_ID = "物品ID"

ITEM_PATCHES = {
    "999999": {
        "名称": "Linh Ngọc",
        "类型说明": "Tiền tệ nạp",
        "描述": "Tiền tệ nạp dùng để mua gói VIP, ưu đãi và vật phẩm đặc biệt trong Meow 3Q.",
        "品质": "5",
    }
}


def encode_utf(value: str) -> bytes:
    data = value.encode("utf-8")
    if len(data) > 65535:
        raise ValueError("Template field is too large")
    return struct.pack(">H", len(data)) + data


def write_tables(tables: dict[str, list[list[str]]]) -> bytes:
    payload = bytearray()
    for table_name, rows in tables.items():
        payload.extend(encode_utf(table_name))
        payload.extend(struct.pack(">i", len(rows)))
        for row in rows:
            encoded_row = b"".join(encode_utf(value) for value in row)
            if len(encoded_row) > 65535:
                raise ValueError(f"Row in {table_name} is too large")
            payload.extend(struct.pack(">H", len(encoded_row)))
            payload.extend(encoded_row)
    return zlib.compress(bytes(payload), 9)


def main() -> None:
    tables = read_tables(SOURCE.read_bytes())
    rows = tables[TABLE_ITEMS]
    headers = rows[0]
    patched = 0

    item_id_index = headers.index(COL_ITEM_ID)
    for row in rows[1:]:
        item_id = row[item_id_index]
        changes = ITEM_PATCHES.get(item_id)
        if not changes:
            continue
        for field, value in changes.items():
            row[headers.index(field)] = value
        patched += 1

    if patched != len(ITEM_PATCHES):
        raise RuntimeError(f"Expected {len(ITEM_PATCHES)} items, patched {patched}")

    SOURCE.write_bytes(write_tables(tables))
    print(f"Patched {patched} game item(s) -> {SOURCE}")


if __name__ == "__main__":
    main()
