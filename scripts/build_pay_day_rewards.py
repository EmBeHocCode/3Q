"""Build the idempotent SQL migration for high pay-day milestones."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CATALOG_PATH = ROOT / "home/web/tool/data/item-catalog.json"
OUTPUT = ROOT / "home/web/build/sql/pay_day_high_milestones.sql"

MILESTONES = {
    10_000_000: [
        ("0:0", 100_000_000), ("0:4", 100_000_000),
        ("3:100231", 10), ("3:100232", 5), ("3:100233", 2),
        ("3:100250", 1), ("3:100251", 1), ("3:100324", 10),
    ],
    20_000_000: [
        ("0:0", 200_000_000), ("0:4", 200_000_000),
        ("3:100299", 15), ("3:100300", 8), ("3:100301", 3),
        ("3:100273", 1), ("3:100274", 1), ("3:100324", 20),
    ],
    50_000_000: [
        ("0:0", 500_000_000), ("0:4", 500_000_000),
        ("3:100302", 20), ("3:100303", 10), ("3:100304", 5),
        ("3:100318", 2), ("3:100319", 2), ("3:100324", 50),
    ],
    100_000_000: [
        ("0:0", 1_000_000_000), ("0:4", 1_000_000_000),
        ("3:110112", 20), ("3:110113", 10), ("3:110114", 5),
        ("3:100320", 3), ("3:100321", 3),
        ("3:100326", 3), ("3:100506", 3), ("3:100324", 100),
    ],
}

RESOURCE_META = {
    "0:0": {"name": "Vàng Game", "icon": "2"},
    "0:4": {"name": "EXP Anh Hùng", "icon": "3"},
}


def main() -> None:
    catalog = json.loads(CATALOG_PATH.read_text(encoding="utf-8"))
    item_map = {item["reward"]: item for item in catalog["items"]}
    lines = ["START TRANSACTION;", ""]

    for need, rewards in MILESTONES.items():
        gifts = []
        for reward_code, amount in rewards:
            if reward_code in RESOURCE_META:
                meta = RESOURCE_META[reward_code]
            else:
                item = item_map[reward_code]
                meta = {"name": item["name"], "icon": str(item["icon"])}
            gifts.append({
                "id": reward_code,
                "name": meta["name"],
                "amount": str(amount),
                "icon": meta["icon"],
            })

        payload = json.dumps(gifts, ensure_ascii=False, separators=(",", ":")).replace("'", "''")
        lines.extend([
            "INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)",
            f"SELECT 2, {need}, '{payload}'",
            "WHERE NOT EXISTS (",
            f"  SELECT 1 FROM `ny_event_milestone` WHERE `event_id` = 2 AND `need` = {need}",
            ");",
            "",
            "UPDATE `ny_event_milestone`",
            f"SET `gifts` = '{payload}'",
            f"WHERE `event_id` = 2 AND `need` = {need};",
            "",
        ])

    lines.append("COMMIT;")
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"Built {len(MILESTONES)} high recharge milestones -> {OUTPUT}")


if __name__ == "__main__":
    main()
