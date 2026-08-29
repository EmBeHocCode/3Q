"""Patch VIP privilege gifts, daily packs, and top-up tiers for Meow 3Q."""

from __future__ import annotations

import json
import shutil
from pathlib import Path

from extract_game_catalog import ROOT, SOURCE, read_tables
from patch_game_item_names import write_tables


BACKUP = SOURCE.with_name("templates.bin.before-vip-daily-recharge-20260811.bak")
ID_TXT = ROOT / "home/web/api/id.txt"
RECHARGE_JSON = ROOT / "home/web/game/source/srv/excel/充值项.json"


VIP_GIFTS: dict[int, dict[str, str]] = {
    1: {"gift": "0:1:2000#3:100022:5#3:100001:300#0:0:3000000", "show": "1888", "cost": "288", "title": "Quà VIP"},
    2: {"gift": "0:1:4000#3:100022:8#3:100001:500#0:4:2000000", "show": "3888", "cost": "688", "title": "Quà VIP"},
    3: {"gift": "3:100025:3#3:100096:1#3:100022:12#0:0:6000000", "show": "5888", "cost": "988", "title": "Quà VIP"},
    4: {"gift": "3:500024:1#3:100096:2#3:100025:5#3:100216:300", "show": "9888", "cost": "1888", "title": "Quà VIP"},
    5: {"gift": "3:400022:1#3:500024:1#3:100252:12#3:100253:12", "show": "12880", "cost": "2288", "title": "Quà VIP"},
    6: {"gift": "3:500054:1#3:100299:1#3:500024:2#3:100342:10", "show": "18880", "cost": "3288", "title": "Quà VIP"},
    7: {"gift": "3:400023:1#3:500054:1#3:100300:1#3:100318:1", "show": "24880", "cost": "4288", "title": "Quà VIP"},
    8: {"gift": "3:500095:1#3:100301:1#3:100302:1#3:100321:1", "show": "32880", "cost": "5288", "title": "Quà VIP"},
    9: {"gift": "3:500053:1#3:401001:1#3:500059:1#3:100326:1", "show": "40880", "cost": "6288", "title": "Quà VIP"},
    10: {"gift": "3:400023:2#3:500094:1#3:100303:1#3:590006:1", "show": "50880", "cost": "7288", "title": "Quà VIP"},
    11: {"gift": "3:500095:2#3:401001:2#3:100506:1#3:560002:1", "show": "62880", "cost": "8888", "title": "Quà VIP"},
    12: {"gift": "3:500053:2#3:500094:2#3:110112:2#3:500030:1", "show": "76880", "cost": "10888", "title": "Quà VIP"},
    13: {"gift": "3:400023:3#3:401001:3#3:110113:2#3:580001:1", "show": "92880", "cost": "12888", "title": "Quà VVIP"},
    14: {"gift": "3:500053:3#3:500094:3#3:110114:1#3:590006:2", "show": "112880", "cost": "15888", "title": "Quà VVIP"},
    15: {"gift": "3:500095:4#3:401001:4#3:100506:2#3:580001:2#3:100342:30", "show": "138880", "cost": "18888", "title": "Quà VVIP"},
    16: {"gift": "3:400023:5#3:500053:4#3:110114:2#3:590006:3#3:560002:2", "show": "168880", "cost": "22888", "title": "Quà VVIP"},
    17: {"gift": "3:500095:6#3:500094:4#3:401001:5#3:100506:4#3:580001:3", "show": "198880", "cost": "26888", "title": "Quà VVIP"},
    18: {"gift": "3:400023:8#3:500053:6#3:401001:6#3:110114:5#3:590006:5", "show": "248880", "cost": "32888", "title": "Quà Đế Vương"},
}

VIP_DAILY: dict[int, str] = {
    1: "0:1:3000#3:100022:1",
    2: "0:1:5000#3:100022:1",
    3: "0:1:7000#3:100022:2",
    4: "0:1:9000#3:100025:1",
    5: "0:1:12000#3:100025:1",
    6: "0:1:15000#3:100252:2",
    7: "0:1:18000#3:100253:2",
    8: "0:1:22000#3:100342:2",
    9: "0:1:26000#3:100342:3",
    10: "0:1:30000#3:100342:4",
    11: "0:1:36000#3:100342:5",
    12: "0:1:42000#3:100342:6",
    13: "0:1:50000#3:100342:8",
    14: "0:1:60000#3:100342:10",
    15: "0:1:72000#3:100342:12",
    16: "0:1:85000#3:100342:15",
    17: "0:1:100000#3:100342:18",
    18: "0:1:120000#3:100342:25",
}

DAILY_PACKS: dict[str, dict[str, str]] = {
    "1": {"name": "Gói Ngày - Khởi Đầu", "reward": "3:100022:3#3:100001:300#0:0:2000000#0:4:1500000", "knb": "0:1:10000"},
    "2": {"name": "Gói Ngày - Tinh Anh", "reward": "3:100022:6#3:400022:1#3:100025:2#3:100216:300", "knb": "0:1:25000"},
    "3": {"name": "Gói Ngày - Hào Hoa", "reward": "3:500054:1#3:500024:1#3:100299:1#3:100342:8", "knb": "0:1:50000"},
    "4": {"name": "Gói Ngày - Linh Thú", "reward": "3:100252:10#3:100253:10#3:100318:1#0:4:2500000", "knb": "0:1:10000"},
    "5": {"name": "Gói Ngày - Phá Cảnh", "reward": "3:100096:2#3:100146:5#3:100300:1#3:100342:10", "knb": "0:1:25000"},
    "6": {"name": "Gói Ngày - Thần Trang", "reward": "3:401001:1#3:500059:1#3:100301:1#3:100342:15", "knb": "0:1:50000"},
    "7": {"name": "Gói Ngày - Chiêu Mộ", "reward": "3:100022:10#3:400022:1#3:500024:1#0:0:5000000", "knb": "0:1:10000"},
    "8": {"name": "Gói Ngày - Tam Quốc", "reward": "3:500054:1#3:500095:1#3:100300:1#3:100342:12", "knb": "0:1:25000"},
    "9": {"name": "Gói Ngày - Thánh Thần", "reward": "3:500053:1#3:500094:1#3:100302:1#3:590006:1", "knb": "0:1:50000"},
}

RECHARGE_ROWS = [
    ["9", "Nạp 5.000.000 VND", "pay6", "5000000", "5000000", "5000000", "18009"],
    ["10", "Nạp 10.000.000 VND", "pay6", "10000000", "10000000", "10000000", "18010"],
]


def item_ids(reward: str) -> set[str]:
    values: set[str] = set()
    for part in reward.split("#"):
        bits = part.split(":")
        if len(bits) >= 3 and bits[0] == "3":
            values.add(bits[1])
    return values


def patch_id_txt() -> None:
    text = ID_TXT.read_text(encoding="utf-8")
    lines = [line for line in text.splitlines() if line.strip()]
    additions = {"18009": "18009;5000000", "18010": "18010;10000000"}
    existing = {line.split(";", 1)[0]: line for line in lines if ";" in line}
    if all(k in existing for k in additions):
        return
    output: list[str] = []
    inserted = False
    for line in lines:
        output.append(line)
        if line.startswith("18008;"):
            for key, value in additions.items():
                if key not in existing:
                    output.append(value)
            inserted = True
    if not inserted:
        output.extend(value for key, value in additions.items() if key not in existing)
    ID_TXT.write_text("\n".join(output) + "\n", encoding="utf-8")


def patch_recharge_json() -> None:
    payload = json.loads(RECHARGE_JSON.read_text(encoding="utf-8"))
    data = payload["data"]
    by_id = {int(row["id"]): row for row in data}
    specs = [
        (18009, "充值-500万VND", 5000.0, 9, 50000),
        (18010, "充值-1000万VND", 10000.0, 10, 100000),
    ]
    changed = False
    for item_id, name, rmb, shop_item_id, vip_points in specs:
        row = by_id.get(item_id)
        if row is None:
            row = dict(by_id[18008])
            row["id"] = item_id
            row["tid"] = item_id
            data.append(row)
            changed = True
        before = dict(row)
        row.update(
            {
                "name": name,
                "rmb": rmb,
                "funcId": 710,
                "shopItemId": shop_item_id,
                "vipPoints": vip_points,
                "outsideLimit": False,
            }
        )
        changed = changed or row != before
    if changed:
        data.sort(key=lambda row: int(row["id"]))
        RECHARGE_JSON.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")


def main() -> None:
    tables = read_tables(SOURCE.read_bytes())
    valid_items = {row[0] for row in tables["基础物品"][1:] if row and row[0]}
    wanted: set[str] = set()
    for patch in VIP_GIFTS.values():
        wanted |= item_ids(patch["gift"])
    for reward in VIP_DAILY.values():
        wanted |= item_ids(reward)
    for patch in DAILY_PACKS.values():
        wanted |= item_ids(patch["reward"])
    missing = sorted(wanted - valid_items)
    if missing:
        raise RuntimeError("Missing item IDs: " + ", ".join(missing))

    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    vip_rows = tables["vip等级"]
    vip_headers = vip_rows[0]
    vip_i = {name: vip_headers.index(name) for name in vip_headers}
    vip_count = 0
    for row in vip_rows[1:]:
        if not row or not row[vip_i["等级"]].isdigit():
            continue
        vip = int(row[vip_i["等级"]])
        if vip in VIP_GIFTS:
            patch = VIP_GIFTS[vip]
            row[vip_i["特权礼包"]] = patch["gift"]
            row[vip_i["特权礼包展示价格"]] = patch["show"]
            row[vip_i["特权礼包元宝消耗"]] = patch["cost"]
            row[vip_i["每日福利"]] = VIP_DAILY[vip]
            row[vip_i["礼包展示"]] = patch["title"]
            row[vip_i["礼包展示图片"]] = f"pic{min(max(vip, 1), 6)}"
            vip_count += 1

    daily_rows = tables["每日礼包"]
    daily_headers = daily_rows[0]
    daily_i = {name: daily_headers.index(name) for name in daily_headers}
    daily_count = 0
    for row in daily_rows[1:]:
        if not row:
            continue
        patch = DAILY_PACKS.get(row[daily_i["ID"]])
        if not patch:
            continue
        row[daily_i["礼包名称"]] = patch["name"]
        row[daily_i["翻倍奖励"]] = patch["knb"]
        row[daily_i["一般奖励"]] = patch["reward"]
        row[daily_i["翻倍系数"]] = "2"
        daily_count += 1

    pay_rows = tables["付费充值"]
    pay_headers = pay_rows[0]
    pay_i = {name: pay_headers.index(name) for name in pay_headers}
    by_id = {row[pay_i["ID"]]: row for row in pay_rows[1:] if row}
    recharge_count = 0
    for new_row in RECHARGE_ROWS:
        old = by_id.get(new_row[0])
        if old is None:
            pay_rows.append(new_row[:])
        else:
            old[:] = new_row[:]
        recharge_count += 1

    SOURCE.write_bytes(write_tables(tables))
    patch_id_txt()
    patch_recharge_json()
    print(f"Patched VIP gifts: {vip_count}")
    print(f"Patched daily packs: {daily_count}")
    print(f"Added/updated recharge tiers: {recharge_count}")
    print(f"Backup: {BACKUP}")


if __name__ == "__main__":
    main()
