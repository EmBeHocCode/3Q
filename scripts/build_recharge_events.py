"""Build balanced, idempotent recharge events from real game item metadata."""

from __future__ import annotations

import json
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
CATALOG_PATH = ROOT / "home/web/tool/data/item-catalog.json"
OUTPUT = ROOT / "home/web/build/sql/recharge_events.sql"

# Core progression materials. Values are calibrated around the existing 5m daily
# pack the owner prefers; recurring event multipliers are applied below.
CORE = {
    20_000:       (400_000, 0, 0, 0, 10, 10, 20, 0, 0, 2_000),
    50_000:       (1_000_000, 20, 0, 0, 25, 25, 50, 1, 0, 5_000),
    100_000:      (2_000_000, 30, 0, 0, 50, 50, 100, 2, 0, 10_000),
    200_000:      (4_000_000, 50, 0, 0, 100, 100, 200, 5, 0, 15_000),
    500_000:      (6_000_000, 120, 0, 15_000, 200, 200, 500, 8, 5, 25_000),
    1_000_000:    (9_000_000, 250, 0, 25_000, 400, 500, 750, 10, 10, 50_000),
    2_000_000:    (15_000_000, 450, 0, 45_000, 600, 1_000, 1_500, 15, 20, 80_000),
    3_000_000:    (25_000_000, 650, 200, 65_000, 800, 1_200, 1_800, 25, 30, 110_000),
    5_000_000:    (50_000_000, 1_100, 400, 100_000, 1_500, 2_000, 2_800, 55, 50, 200_000),
    10_000_000:   (100_000_000, 2_000, 800, 200_000, 3_000, 4_000, 5_500, 110, 100, 400_000),
    20_000_000:   (200_000_000, 3_500, 1_500, 350_000, 5_000, 7_000, 10_000, 200, 200, 700_000),
    50_000_000:   (500_000_000, 7_500, 3_000, 750_000, 10_000, 15_000, 20_000, 500, 500, 1_500_000),
}

DAILY_TIERS = [20_000, 50_000, 100_000, 200_000, 500_000, 1_000_000, 2_000_000, 3_000_000, 5_000_000, 10_000_000]
LONG_TIERS = [50_000, 100_000, 200_000, 500_000, 1_000_000, 2_000_000, 5_000_000, 10_000_000, 20_000_000, 50_000_000]

# Featured rewards make each upper tier visibly and functionally better.
PREMIUM = {
    "pay_day": {
        100_000: [("3:500024", 3)],
        200_000: [("3:500024", 5)],
        500_000: [("3:500024", 10), ("3:400023", 10), ("3:500059", 1)],
        1_000_000: [("3:500024", 15), ("3:400023", 50), ("3:500059", 1), ("3:401001", 1)],
        2_000_000: [("3:500024", 25), ("3:400023", 100), ("3:500094", 2), ("3:500059", 2), ("3:401001", 2)],
        3_000_000: [("3:500024", 45), ("3:400023", 150), ("3:500094", 3), ("3:500059", 2), ("3:401001", 2)],
        5_000_000: [("3:400023", 150), ("3:500094", 5), ("3:500059", 4), ("3:401001", 3), ("3:100231", 10), ("3:100232", 5), ("3:100233", 2)],
        10_000_000: [("3:400023", 300), ("3:500094", 10), ("3:500059", 8), ("3:401001", 6), ("3:100231", 20), ("3:100232", 10), ("3:100233", 5), ("3:100318", 1), ("3:100319", 1)],
    },
    "pay_week": {
        100_000: [("3:500024", 1)],
        200_000: [("3:500024", 2)],
        500_000: [("3:400023", 10), ("3:500059", 1)],
        1_000_000: [("3:400023", 30), ("3:500059", 1), ("3:100231", 2)],
        2_000_000: [("3:400023", 60), ("3:500094", 1), ("3:500059", 2), ("3:401001", 1), ("3:100231", 5), ("3:100232", 2)],
        5_000_000: [("3:400023", 120), ("3:500094", 3), ("3:500059", 3), ("3:401001", 2), ("3:100231", 10), ("3:100232", 5), ("3:100233", 2)],
        10_000_000: [("3:400023", 200), ("3:500094", 5), ("3:500059", 5), ("3:401001", 3), ("3:100299", 10), ("3:100300", 5), ("3:100301", 2)],
        20_000_000: [("3:400023", 300), ("3:500094", 8), ("3:500059", 8), ("3:401001", 5), ("3:100302", 10), ("3:100303", 5), ("3:100304", 2), ("3:100250", 1), ("3:100251", 1)],
        50_000_000: [("3:400023", 500), ("3:500094", 15), ("3:500059", 15), ("3:401001", 10), ("3:110112", 10), ("3:110113", 5), ("3:110114", 3), ("3:100318", 1), ("3:100319", 1), ("3:100326", 1), ("3:100506", 1)],
    },
    "pay_month": {
        50_000: [("3:500024", 1)],
        100_000: [("3:500024", 2)],
        200_000: [("3:500024", 4), ("3:400023", 5)],
        500_000: [("3:400023", 20), ("3:500059", 1), ("3:100231", 2)],
        1_000_000: [("3:400023", 50), ("3:500094", 1), ("3:500059", 2), ("3:401001", 1), ("3:100231", 5), ("3:100232", 2)],
        2_000_000: [("3:400023", 100), ("3:500094", 3), ("3:500059", 3), ("3:401001", 2), ("3:100231", 10), ("3:100232", 5), ("3:100233", 2)],
        5_000_000: [("3:400023", 200), ("3:500094", 5), ("3:500059", 5), ("3:401001", 3), ("3:100299", 12), ("3:100300", 6), ("3:100301", 3)],
        10_000_000: [("3:400023", 350), ("3:500094", 10), ("3:500059", 10), ("3:401001", 6), ("3:100302", 15), ("3:100303", 8), ("3:100304", 4), ("3:100318", 1), ("3:100319", 1)],
        20_000_000: [("3:400023", 600), ("3:500094", 18), ("3:500059", 18), ("3:401001", 10), ("3:110112", 15), ("3:110113", 8), ("3:110114", 5), ("3:100326", 2), ("3:100506", 2)],
        50_000_000: [("3:400023", 1_200), ("3:500094", 35), ("3:500059", 35), ("3:401001", 20), ("3:110112", 30), ("3:110113", 15), ("3:110114", 10), ("3:100320", 3), ("3:100321", 3), ("3:100326", 5), ("3:100506", 5)],
    },
    "pay_all": {
        50_000: [("3:500024", 3), ("3:400023", 10)],
        100_000: [("3:500024", 5), ("3:400023", 20), ("3:500059", 1)],
        200_000: [("3:500024", 10), ("3:400023", 40), ("3:500059", 2), ("3:401001", 1)],
        500_000: [("3:400023", 80), ("3:500094", 2), ("3:500059", 4), ("3:401001", 2), ("3:100231", 5), ("3:100232", 2)],
        1_000_000: [("3:400023", 150), ("3:500094", 4), ("3:500059", 6), ("3:401001", 4), ("3:100231", 10), ("3:100232", 5), ("3:100233", 2), ("3:100250", 1), ("3:100251", 1)],
        2_000_000: [("3:400023", 250), ("3:500094", 8), ("3:500059", 10), ("3:401001", 6), ("3:100299", 15), ("3:100300", 8), ("3:100301", 4), ("3:100273", 1), ("3:100274", 1)],
        5_000_000: [("3:400023", 500), ("3:500094", 15), ("3:500059", 18), ("3:401001", 10), ("3:100302", 20), ("3:100303", 10), ("3:100304", 5), ("3:100318", 2), ("3:100319", 2), ("3:100324", 50)],
        10_000_000: [("3:400023", 800), ("3:500094", 25), ("3:500059", 25), ("3:401001", 15), ("3:110112", 20), ("3:110113", 10), ("3:110114", 6), ("3:100320", 3), ("3:100321", 3), ("3:100326", 3), ("3:100506", 3), ("3:100324", 100)],
        20_000_000: [("3:400023", 1_500), ("3:500094", 40), ("3:500059", 40), ("3:401001", 25), ("3:110112", 35), ("3:110113", 18), ("3:110114", 10), ("3:100320", 5), ("3:100321", 5), ("3:100326", 6), ("3:100506", 6), ("3:100324", 200)],
        50_000_000: [("3:400023", 3_000), ("3:500094", 80), ("3:500059", 80), ("3:401001", 50), ("3:110112", 70), ("3:110113", 35), ("3:110114", 20), ("3:100320", 10), ("3:100321", 10), ("3:100326", 15), ("3:100506", 15), ("3:100324", 500)],
    },
}

EVENTS = {
    "pay_day": ("Tích Nạp Ngày", "Làm mới mỗi ngày.", DAILY_TIERS, 1.0),
    "pay_week": ("Tích Nạp Tuần", "Làm mới vào đầu mỗi tuần ISO.", LONG_TIERS, 0.55),
    "pay_month": ("Tích Nạp Tháng", "Làm mới vào đầu mỗi tháng.", LONG_TIERS, 0.8),
    "pay_all": ("Tích Nạp Vĩnh Viễn", "Không đặt lại; mỗi mốc chỉ nhận một lần trong suốt vòng đời tài khoản.", LONG_TIERS, 1.6),
}

RESOURCE_META = {
    "0:0": {"name": "Vàng Game", "icon": "2"},
    "0:4": {"name": "EXP Anh Hùng", "icon": "3"},
    "5:20001": {"name": "Long Hồn", "icon": "FW10117"},
}


def sql_text(value: str) -> str:
    return value.replace("'", "''")


def scaled(value: int, factor: float) -> int:
    return max(1, int(round(value * factor))) if value else 0


def core_rewards(need: int, factor: float) -> list[tuple[str, int]]:
    gold, soap, divine, stone, tiger, pet_pill, pet_book, soul, fire, jade = CORE[need]
    values = [
        ("0:0", gold), ("0:4", gold), ("3:100096", soap), ("3:100146", divine),
        ("3:100001", stone), ("3:100342", tiger), ("3:100252", pet_pill),
        ("3:100253", pet_book), ("5:20001", soul), ("3:100258", fire),
        ("3:100216", jade), ("3:100004", jade),
    ]
    return [(code, scaled(amount, factor)) for code, amount in values if amount]


def gift_json(rewards: list[tuple[str, int]], item_map: dict[str, dict]) -> str:
    gifts = []
    seen = set()
    for reward_code, amount in rewards:
        if reward_code in seen:
            raise ValueError(f"Duplicate reward {reward_code}")
        seen.add(reward_code)
        meta = RESOURCE_META[reward_code] if reward_code in RESOURCE_META else item_map[reward_code]
        gifts.append({"id": reward_code, "name": meta["name"], "amount": str(amount), "icon": str(meta["icon"])})
    return sql_text(json.dumps(gifts, ensure_ascii=False, separators=(",", ":")))


def append_upsert(lines: list[str], event_var: str, need: int, payload: str) -> None:
    lines.extend([
        "INSERT INTO `ny_event_milestone` (`event_id`, `need`, `gifts`)",
        f"SELECT {event_var}, {need}, '{payload}'",
        f"WHERE NOT EXISTS (SELECT 1 FROM `ny_event_milestone` WHERE `event_id`={event_var} AND `need`={need});",
        f"UPDATE `ny_event_milestone` SET `gifts`='{payload}' WHERE `event_id`={event_var} AND `need`={need};",
        "",
    ])


def main() -> None:
    catalog = json.loads(CATALOG_PATH.read_text(encoding="utf-8"))
    item_map = {item["reward"]: item for item in catalog["items"]}
    all_rewards = {code for event_type, (_, _, tiers, factor) in EVENTS.items() for need in tiers for code, _ in core_rewards(need, factor) + PREMIUM[event_type].get(need, [])}
    missing = sorted(all_rewards - set(item_map) - set(RESOURCE_META))
    if missing:
        raise SystemExit(f"Missing reward codes: {', '.join(missing)}")

    lines = [
        "START TRANSACTION;", "",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `cash_coin` DOUBLE(50,0) UNSIGNED DEFAULT 0 AFTER `coin`;",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `pay_week` DOUBLE(50,0) DEFAULT 0 AFTER `pay_day`;",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `week` VARCHAR(20) NOT NULL DEFAULT '' AFTER `year`;",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `week_year` VARCHAR(20) NOT NULL DEFAULT '' AFTER `week`;",
        "UPDATE `ny_user` SET `pay_week`=`pay_day`, `week`=DATE_FORMAT(NOW(), '%v'), `week_year`=DATE_FORMAT(NOW(), '%x') WHERE `week`='' OR `week_year`='';", "",
    ]

    for index, (event_type, (name, info, tiers, factor)) in enumerate(EVENTS.items(), start=1):
        event_var = f"@event_{index}"
        lines.extend([
            "INSERT INTO `ny_event` (`name`,`info`,`type`,`icon`,`milestone_type`,`comparison`,`prefix`,`suffix`,`expires_time`,`display`,`update_time`)",
            f"SELECT '{sql_text(name)}','{sql_text(info)}','{event_type}',NULL,'money','>=','Nạp','VNĐ',0,1,UNIX_TIMESTAMP()",
            f"WHERE NOT EXISTS (SELECT 1 FROM `ny_event` WHERE `type`='{event_type}');",
            f"UPDATE `ny_event` SET `name`='{sql_text(name)}',`info`='{sql_text(info)}',`milestone_type`='money',`comparison`='>=',`prefix`='Nạp',`suffix`='VNĐ',`expires_time`=0,`display`=1,`update_time`=UNIX_TIMESTAMP() WHERE `type`='{event_type}';",
            f"SET {event_var}=(SELECT `id` FROM `ny_event` WHERE `type`='{event_type}' ORDER BY `id` LIMIT 1);", "",
            f"DELETE FROM `ny_event_milestone` WHERE `event_id`={event_var} AND `need` NOT IN ({','.join(map(str, tiers))});", "",
        ])
        for need in tiers:
            rewards = core_rewards(need, factor) + PREMIUM[event_type].get(need, [])
            append_upsert(lines, event_var, need, gift_json(rewards, item_map))

    lines.extend(["COMMIT;", ""])
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text("\n".join(lines), encoding="utf-8")
    print(f"Built {sum(len(data[2]) for data in EVENTS.values())} balanced recharge milestones -> {OUTPUT}")


if __name__ == "__main__":
    main()
