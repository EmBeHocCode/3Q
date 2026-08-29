"""Rebalance in-game VIP privilege gifts and front VIP shop offers.

This patches the compressed Laya template bundle used by the game client.
The goal is to make VIP1..VIP18 rewards scale cleanly, with VVIP tiers
showing rare hero/gear/relic/beast packs instead of the old repeated bundle.
"""

from __future__ import annotations

import shutil
from pathlib import Path

from extract_game_catalog import SOURCE, read_tables, to_rows
from patch_game_item_names import write_tables


BACKUP = SOURCE.with_name("templates.bin.before-vip-rewards-20260811.bak")


VIP_PRIVILEGE_GIFTS: dict[int, dict[str, str]] = {
    1: {
        "gift": "0:0:2000000#0:4:1000000#3:100001:300#3:100022:5",
        "show": "1288",
        "cost": "288",
        "daily": "0:1:2000#3:100022:1",
    },
    2: {
        "gift": "0:0:3000000#0:4:1500000#3:100001:500#3:100022:8",
        "show": "2880",
        "cost": "688",
        "daily": "0:1:4000#3:100022:1",
    },
    3: {
        "gift": "0:0:5000000#0:4:2500000#3:100025:2#3:100022:12",
        "show": "4288",
        "cost": "988",
        "daily": "0:1:6000#3:100022:2",
    },
    4: {
        "gift": "3:500024:1#3:100096:2#3:100001:900#3:100025:4",
        "show": "8888",
        "cost": "1888",
        "daily": "0:1:8000#3:100025:1",
    },
    5: {
        "gift": "3:400022:1#3:500024:1#3:100216:500#3:100252:10",
        "show": "10880",
        "cost": "2288",
        "daily": "0:1:10000#3:100025:1",
    },
    6: {
        "gift": "3:500054:1#3:500024:2#3:100216:800#3:100252:15",
        "show": "15880",
        "cost": "3288",
        "daily": "0:1:12000#3:100252:2",
    },
    7: {
        "gift": "3:400023:1#3:500054:1#3:500024:2#3:100253:20",
        "show": "20880",
        "cost": "4288",
        "daily": "0:1:14000#3:100252:3",
    },
    8: {
        "gift": "3:500095:1#3:100299:2#3:100300:1#3:100342:15",
        "show": "25880",
        "cost": "5288",
        "daily": "0:1:16000#3:100342:2",
    },
    9: {
        "gift": "3:500053:1#3:401001:1#3:500059:1#3:100301:1",
        "show": "30880",
        "cost": "6288",
        "daily": "0:1:18000#3:100342:3",
    },
    10: {
        "gift": "3:400023:2#3:500054:1#3:500094:1#3:100302:1",
        "show": "36880",
        "cost": "7288",
        "daily": "0:1:20000#3:100342:4",
    },
    11: {
        "gift": "3:500095:2#3:500024:3#3:500094:1#3:100303:1",
        "show": "44880",
        "cost": "8888",
        "daily": "0:1:24000#3:100342:5",
    },
    12: {
        "gift": "3:500053:2#3:401001:2#3:100302:2#3:100326:1",
        "show": "54880",
        "cost": "10888",
        "daily": "0:1:28000#3:100342:6",
    },
    13: {
        "gift": "3:400023:3#3:500094:2#3:110112:2#3:100506:1",
        "show": "64880",
        "cost": "12888",
        "daily": "0:1:32000#3:100342:8",
    },
    14: {
        "gift": "3:500053:3#3:401001:3#3:110113:2#3:100506:1",
        "show": "78880",
        "cost": "15888",
        "daily": "0:1:36000#3:100342:10",
    },
    15: {
        "gift": "3:500095:4#3:500094:3#3:110114:1#3:100506:2#3:100342:30",
        "show": "94880",
        "cost": "18888",
        "daily": "0:1:42000#3:100342:12",
    },
    16: {
        "gift": "3:400023:5#3:500053:4#3:401001:4#3:110114:2#3:100506:3",
        "show": "114880",
        "cost": "22888",
        "daily": "0:1:50000#3:100342:15",
    },
    17: {
        "gift": "3:500095:6#3:500053:5#3:500094:4#3:110114:3#3:100506:4",
        "show": "134880",
        "cost": "26888",
        "daily": "0:1:60000#3:100342:18",
    },
    18: {
        "gift": "3:400023:8#3:500053:6#3:401001:6#3:110114:5#3:100506:5",
        "show": "164880",
        "cost": "32888",
        "daily": "0:1:80000#3:100342:25",
    },
}


SHOP_FRONT_OFFERS: dict[int, list[tuple[str, str]]] = {
    1: [
        ("3:100022:5", "0:1:100"),
        ("3:100001:300", "0:1:150"),
        ("3:500024:1", "3:999999:20000"),
        ("3:400022:1", "3:999999:30000"),
    ],
    2: [
        ("3:100022:8", "0:1:160"),
        ("3:100001:500", "0:1:250"),
        ("3:100025:2", "0:1:600"),
        ("3:500024:1", "3:999999:22000"),
    ],
    3: [
        ("3:100022:10", "0:1:200"),
        ("3:100025:3", "0:1:900"),
        ("3:400022:1", "3:999999:28000"),
        ("3:500024:1", "3:999999:25000"),
    ],
    4: [
        ("3:100025:5", "0:1:1200"),
        ("3:100096:2", "0:1:1800"),
        ("3:400022:1", "3:999999:30000"),
        ("3:500024:1", "3:999999:28000"),
    ],
    5: [
        ("3:400022:1", "3:999999:30000"),
        ("3:500054:1", "3:999999:45000"),
        ("3:500024:1", "3:999999:30000"),
        ("3:100216:500", "0:1:2500"),
        ("3:100252:10", "3:999999:20000"),
    ],
    6: [
        ("3:500054:1", "3:999999:45000"),
        ("3:500024:2", "3:999999:55000"),
        ("3:100096:3", "0:1:2500"),
        ("3:100216:800", "0:1:3000"),
        ("3:100253:15", "3:999999:25000"),
    ],
    7: [
        ("3:400023:1", "3:999999:60000"),
        ("3:500054:1", "3:999999:45000"),
        ("3:500024:2", "3:999999:55000"),
        ("3:100299:1", "3:999999:35000"),
        ("3:100342:10", "0:1:3500"),
    ],
    8: [
        ("3:500095:1", "3:999999:70000"),
        ("3:400023:1", "3:999999:60000"),
        ("3:100300:1", "3:999999:50000"),
        ("3:500024:2", "3:999999:60000"),
        ("3:100342:15", "0:1:4500"),
    ],
    9: [
        ("3:500053:1", "3:999999:90000"),
        ("3:401001:1", "3:999999:90000"),
        ("3:500059:1", "3:999999:70000"),
        ("3:100301:1", "3:999999:70000"),
        ("3:100342:20", "0:1:5000"),
    ],
    10: [
        ("3:400023:2", "3:999999:110000"),
        ("3:500054:1", "3:999999:45000"),
        ("3:500094:1", "3:999999:100000"),
        ("3:100302:1", "3:999999:90000"),
        ("3:100326:1", "3:999999:80000"),
    ],
    11: [
        ("3:500095:2", "3:999999:130000"),
        ("3:500024:3", "3:999999:90000"),
        ("3:500094:1", "3:999999:100000"),
        ("3:100303:1", "3:999999:110000"),
        ("3:100506:1", "3:999999:120000"),
    ],
    12: [
        ("3:500053:2", "3:999999:160000"),
        ("3:401001:2", "3:999999:160000"),
        ("3:100302:2", "3:999999:160000"),
        ("3:100326:1", "3:999999:80000"),
        ("3:110112:1", "3:999999:100000"),
    ],
    13: [
        ("3:400023:3", "3:999999:180000"),
        ("3:500094:2", "3:999999:180000"),
        ("3:110112:2", "3:999999:180000"),
        ("3:100506:1", "3:999999:120000"),
        ("3:100342:30", "0:1:8000"),
    ],
    14: [
        ("3:500053:3", "3:999999:220000"),
        ("3:401001:3", "3:999999:220000"),
        ("3:110113:2", "3:999999:220000"),
        ("3:100506:1", "3:999999:120000"),
        ("3:100342:35", "0:1:9000"),
    ],
    15: [
        ("3:500095:4", "3:999999:260000"),
        ("3:500094:3", "3:999999:260000"),
        ("3:110114:1", "3:999999:180000"),
        ("3:100506:2", "3:999999:220000"),
        ("3:100342:40", "0:1:10000"),
    ],
    16: [
        ("3:400023:5", "3:999999:300000"),
        ("3:500053:4", "3:999999:300000"),
        ("3:401001:4", "3:999999:300000"),
        ("3:110114:2", "3:999999:260000"),
        ("3:100506:3", "3:999999:300000"),
    ],
    17: [
        ("3:500095:6", "3:999999:360000"),
        ("3:500053:5", "3:999999:360000"),
        ("3:500094:4", "3:999999:340000"),
        ("3:110114:3", "3:999999:320000"),
        ("3:100506:4", "3:999999:360000"),
    ],
    18: [
        ("3:400023:8", "3:999999:450000"),
        ("3:500053:6", "3:999999:450000"),
        ("3:401001:6", "3:999999:420000"),
        ("3:110114:5", "3:999999:420000"),
        ("3:100506:5", "3:999999:450000"),
    ],
}


def reward_item_ids(reward: str) -> set[str]:
    ids: set[str] = set()
    for part in reward.split("#"):
        bits = part.split(":")
        if len(bits) >= 3 and bits[0] == "3":
            ids.add(bits[1])
    return ids


def main() -> None:
    tables = read_tables(SOURCE.read_bytes())
    item_rows = to_rows(tables["基础物品"])
    valid_item_ids = {row["物品ID"] for row in item_rows}

    wanted_items: set[str] = set()
    for patch in VIP_PRIVILEGE_GIFTS.values():
        wanted_items.update(reward_item_ids(patch["gift"]))
        wanted_items.update(reward_item_ids(patch["daily"]))
    for offers in SHOP_FRONT_OFFERS.values():
        for item, cost in offers:
            wanted_items.update(reward_item_ids(item))
            wanted_items.update(reward_item_ids(cost))

    missing = sorted(wanted_items - valid_item_ids)
    if missing:
        raise RuntimeError(f"Missing item IDs in 基础物品: {', '.join(missing)}")

    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    vip_rows = tables["vip等级"]
    vip_headers = vip_rows[0]
    vip_indexes = {name: vip_headers.index(name) for name in vip_headers}
    patched_vip = 0
    max_vip = 0
    for row in vip_rows[1:]:
        if not row or not row[vip_indexes["等级"]].isdigit():
            continue
        vip = int(row[vip_indexes["等级"]])
        max_vip = max(max_vip, vip)
        patch = VIP_PRIVILEGE_GIFTS.get(vip)
        if not patch:
            continue
        row[vip_indexes["特权礼包"]] = patch["gift"]
        row[vip_indexes["特权礼包展示价格"]] = patch["show"]
        row[vip_indexes["特权礼包元宝消耗"]] = patch["cost"]
        row[vip_indexes["每日福利"]] = patch["daily"]
        row[vip_indexes["礼包展示"]] = "Quà VIP"
        if vip >= 15:
            row[vip_indexes["礼包展示"]] = "Quà VVIP"
        row[vip_indexes["礼包展示图片"]] = f"pic{min(vip, 6)}"
        patched_vip += 1

    if max_vip != 18 or patched_vip != 18:
        raise RuntimeError(f"Expected VIP1..VIP18, max={max_vip}, patched={patched_vip}")

    shop_rows = tables["vip商城商品"]
    shop_headers = shop_rows[0]
    shop_indexes = {name: shop_headers.index(name) for name in shop_headers}
    patched_shop = 0
    by_vip: dict[int, list[list[str]]] = {}
    for row in shop_rows[1:]:
        vip_value = row[shop_indexes["VIP"]]
        if vip_value.isdigit():
            by_vip.setdefault(int(vip_value), []).append(row)

    for vip, offers in SHOP_FRONT_OFFERS.items():
        rows = sorted(by_vip.get(vip, []), key=lambda r: int(r[shop_indexes["商品排序"]] or r[shop_indexes["ID"]]))
        if len(rows) < len(offers):
            raise RuntimeError(f"VIP{vip} has only {len(rows)} shop rows, need {len(offers)}")
        for row, (item, cost) in zip(rows, offers):
            row[shop_indexes["物品ID"]] = item
            row[shop_indexes["消耗"]] = cost
            row[shop_indexes["限购方式"]] = row[shop_indexes["限购方式"]] or "2"
            row[shop_indexes["限购数量"]] = row[shop_indexes["限购数量"]] or "1"
            row[shop_indexes["是否下架"]] = ""
            patched_shop += 1

    SOURCE.write_bytes(write_tables(tables))
    print(f"Patched VIP privilege gifts: {patched_vip} level(s), max VIP {max_vip}")
    print(f"Patched VIP shop front offers: {patched_shop} row(s)")
    print(f"Backup: {BACKUP}")
    print(f"Output: {SOURCE}")


if __name__ == "__main__":
    main()
