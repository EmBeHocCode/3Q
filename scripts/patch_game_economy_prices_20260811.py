"""Rebalance in-game shop prices for the high-KNB Vietnamese top-up economy.

The recharge table gives a large amount of KNB and first-top-up 100% bonus.
Old game shop prices were tuned for tiny yuanbao values, so this pass scales
purchase costs without touching rewards/gifts.
"""

from __future__ import annotations

import re
import shutil

from extract_game_catalog import SOURCE, read_tables
from patch_game_item_names import write_tables


BACKUP = SOURCE.with_name("templates.bin.before-economy-prices-20260811.bak")

KNB_SCALE = 50
LINH_NGOC_SCALE = 5

REWARD_PART = re.compile(r"^(0:1|3:999999):(\d+)$")

EXCLUDED_TABLES = {
    "付费充值",  # top-up amount, not shop cost
    "每日礼包",  # VNĐ daily pack prices, not KNB shop cost
    "钜惠礼包",  # VNĐ package prices
    "全服限购商品",  # VNĐ package prices
    "限定英雄商品",  # VNĐ package prices
    "限定英雄培养商店",  # VNĐ package prices
    "循环七天乐商店",  # VNĐ package prices
}

STRING_COST_COLUMNS = {
    "资源消耗",
    "消耗",
    "召唤花费",
    "刷新资源消耗",
    "单次消耗道具",
    "消耗道具",
    "道具消耗",
    "金币消耗",  # safe: only scales 0:1 / 3:999999 parts if present
    "封印消耗",
    "挑战消耗",
    "解锁花费一",
    "解锁花费二",
}

NUMERIC_KNB_COLUMNS = {
    "特权礼包元宝消耗",
    "元宝价格",
    "消耗元宝",
    "元宝消耗",
    "混合抽单次元宝价格",
    "购买buff单次消耗元宝",
    "购买挑战次数单次消耗元宝",
    "刷新消耗元宝数",
    "解锁下一章元宝",
    "遗忘消耗元宝",
    "重置消耗货币",
}

NUMERIC_EXCLUDE_WORDS = ("赠送", "奖励", "返还", "额度", "经验", "达成", "充值")


def is_int(value: str) -> bool:
    return bool(re.fullmatch(r"-?\d+", value or ""))


def scaled(value: str, scale: int) -> str:
    if not is_int(value):
        return value
    number = int(value)
    if number <= 0:
        return value
    return str(number * scale)


def scale_reward_cost(value: str) -> tuple[str, int]:
    if not value or ":" not in value:
        return value, 0
    changed = 0
    parts: list[str] = []
    for part in value.split("#"):
        match = REWARD_PART.match(part)
        if not match:
            parts.append(part)
            continue
        key, amount = match.groups()
        scale = KNB_SCALE if key == "0:1" else LINH_NGOC_SCALE
        new_part = f"{key}:{int(amount) * scale}"
        changed += int(new_part != part)
        parts.append(new_part)
    return "#".join(parts), changed


def is_numeric_knb_column(header: str) -> bool:
    if header in NUMERIC_KNB_COLUMNS:
        return True
    if "元宝" not in header:
        return False
    if any(word in header for word in NUMERIC_EXCLUDE_WORDS):
        return False
    return any(word in header for word in ("消耗", "价格", "花费", "购买", "刷新", "解锁"))


def main() -> None:
    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    tables = read_tables(SOURCE.read_bytes())
    changed_strings = 0
    changed_numbers = 0
    touched_tables: dict[str, int] = {}
    samples: list[str] = []

    for table_name, rows in tables.items():
        if table_name in EXCLUDED_TABLES or not rows:
            continue
        headers = rows[0]
        for row in rows[1:]:
            if not row:
                continue
            for idx, header in enumerate(headers[: len(row)]):
                old = row[idx]
                if header in STRING_COST_COLUMNS:
                    new, count = scale_reward_cost(old)
                    if count:
                        row[idx] = new
                        changed_strings += count
                        touched_tables[table_name] = touched_tables.get(table_name, 0) + count
                        if len(samples) < 12:
                            samples.append(f"{table_name}.{header}: {old} -> {new}")
                if is_numeric_knb_column(header) and is_int(old) and int(old) > 0:
                    new = scaled(old, KNB_SCALE)
                    if new != old:
                        row[idx] = new
                        changed_numbers += 1
                        touched_tables[table_name] = touched_tables.get(table_name, 0) + 1
                        if len(samples) < 12:
                            samples.append(f"{table_name}.{header}: {old} -> {new}")

    SOURCE.write_bytes(write_tables(tables))
    print(f"Scaled reward-style cost parts: {changed_strings}")
    print(f"Scaled numeric KNB price fields: {changed_numbers}")
    print("Touched tables:")
    for table, count in sorted(touched_tables.items(), key=lambda item: (-item[1], item[0]))[:30]:
        print(f"  {table}: {count}")
    print("Samples:")
    for sample in samples:
        print(f"  {sample}")
    print(f"Backup: {BACKUP}")


if __name__ == "__main__":
    main()
