"""Extract the GM-safe item catalog from the Laya templates bundle."""

from __future__ import annotations

import json
import struct
import zlib
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "home/web/game/source/template/templates.bin"
OUTPUT = ROOT / "home/web/tool/data/item-catalog.json"


class Reader:
    def __init__(self, data: bytes):
        self.data = data
        self.offset = 0

    @property
    def remaining(self) -> int:
        return len(self.data) - self.offset

    def u16(self) -> int:
        value = struct.unpack_from(">H", self.data, self.offset)[0]
        self.offset += 2
        return value

    def i32(self) -> int:
        value = struct.unpack_from(">i", self.data, self.offset)[0]
        self.offset += 4
        return value

    def utf(self) -> str:
        size = self.u16()
        value = self.data[self.offset : self.offset + size].decode("utf-8")
        self.offset += size
        return value

    def blob(self, size: int) -> bytes:
        value = self.data[self.offset : self.offset + size]
        self.offset += size
        return value


def strings(data: bytes) -> list[str]:
    reader = Reader(data)
    values: list[str] = []
    while reader.remaining:
        values.append(reader.utf())
    return values


def read_tables(data: bytes) -> dict[str, list[list[str]]]:
    reader = Reader(zlib.decompress(data))
    tables: dict[str, list[list[str]]] = {}
    while reader.remaining:
        name = reader.utf()
        row_count = reader.i32()
        rows = [strings(reader.blob(reader.u16())) for _ in range(row_count)]
        tables[name] = rows
    return tables


def to_rows(raw_rows: list[list[str]]) -> list[dict[str, str]]:
    if not raw_rows:
        return []
    headers = raw_rows[0]
    return [dict(zip(headers, row)) for row in raw_rows[1:] if row and row[0]]


def integer(value: str | None) -> int:
    try:
        return int(float(value or 0))
    except (TypeError, ValueError):
        return 0


def main() -> None:
    tables = read_tables(SOURCE.read_bytes())
    text_rows = to_rows(tables.get("文本库", []))
    text_map = {row.get("ID", ""): row.get("目标文本", "") for row in text_rows}

    items = []
    for row in to_rows(tables.get("基础物品", [])):
        item_id = integer(row.get("物品ID"))
        if item_id <= 0:
            continue
        name = text_map.get(row.get("名称YID", ""), row.get("名称", ""))
        description = text_map.get(row.get("描述YID", ""), row.get("描述", ""))
        type_description = text_map.get(row.get("类型说明YID", ""), row.get("类型说明", ""))
        items.append(
            {
                "id": item_id,
                "reward": f"3:{item_id}",
                "name": name or f"Vật phẩm {item_id}",
                "description": description,
                "type": integer(row.get("类型")),
                "typeDescription": type_description,
                "quality": integer(row.get("品质")),
                "icon": row.get("图标", ""),
                "canUse": integer(row.get("是否可直接使用")) == 1,
                "batchUse": integer(row.get("是否可批量使用")) == 1,
            }
        )

    resources = [
        {"id": 0, "reward": "0:0", "name": "Vàng game", "key": "m0"},
        {"id": 1, "reward": "0:1", "name": "Nguyên bảo", "key": "m1"},
        {"id": 4, "reward": "0:4", "name": "EXP anh hùng", "key": "heroExp"},
        {"id": 5, "reward": "0:5", "name": "Điểm tình bạn", "key": "friendship"},
        {"id": 6, "reward": "0:6", "name": "Hồn anh hùng", "key": "heroAsh"},
        {"id": 7, "reward": "0:7", "name": "Tinh thể", "key": "crystal"},
        {"id": 8, "reward": "0:8", "name": "Lá may mắn", "key": "leaf"},
        {"id": 10, "reward": "0:10", "name": "Điểm tài nguyên P0", "key": "p0"},
        {"id": 11, "reward": "0:11", "name": "Điểm tài nguyên P1", "key": "p1"},
        {"id": 12, "reward": "0:12", "name": "Điểm tài nguyên P2", "key": "p2"},
        {"id": 13, "reward": "0:13", "name": "Điểm tài nguyên P3", "key": "p3"},
        {"id": 14, "reward": "0:14", "name": "Điểm tài nguyên P4", "key": "p4"},
        {"id": 16, "reward": "0:16", "name": "Điểm VIP", "key": "vipPoint"},
        {"id": 18, "reward": "0:18", "name": "Điểm đấu trường", "key": "ladderScore"},
        {"id": 19, "reward": "0:19", "name": "Chiến tích liên server", "key": "crossPvpFeats"},
        {"id": 20, "reward": "0:20", "name": "Điểm xếp hạng liên server", "key": "crossGradeScore"},
        {"id": 97, "reward": "0:97", "name": "RMB thử nghiệm BT", "key": "btFakeRmb"},
        {"id": 98, "reward": "0:98", "name": "Điểm VIP BT", "key": "btVipPoint"},
        {"id": 99, "reward": "0:99", "name": "Tiên ngọc BT", "key": "btXy"},
    ]

    payload = {
        "version": 1,
        "source": "template/templates.bin",
        "resources": resources,
        "items": sorted(items, key=lambda item: (not item["canUse"], item["id"])),
    }
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    print(f"Extracted {len(items)} items and {len(resources)} wallet resources -> {OUTPUT}")


if __name__ == "__main__":
    main()
