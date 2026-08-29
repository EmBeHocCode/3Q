"""Build spend and daily-online reward events from the real item catalog."""

from __future__ import annotations

import json
from pathlib import Path

from build_recharge_events import (
    CATALOG_PATH,
    DAILY_TIERS,
    LONG_TIERS,
    RESOURCE_META,
    core_rewards,
    sql_text,
)


ROOT = Path(__file__).resolve().parents[1]
OUTPUT = ROOT / "home/web/build/sql/engagement_events.sql"

SPEND_EVENTS = {
    "spend_day": ("Tiêu Phí Ngày", "Làm mới mỗi ngày.", DAILY_TIERS, 0.25),
    "spend_week": ("Tiêu Phí Tuần", "Làm mới vào đầu mỗi tuần ISO.", LONG_TIERS, 0.18),
    "spend_month": ("Tiêu Phí Tháng", "Làm mới vào đầu mỗi tháng.", LONG_TIERS, 0.30),
    "spend_all": ("Tiêu Phí Vĩnh Viễn", "Không đặt lại; mỗi mốc chỉ nhận một lần.", LONG_TIERS, 0.60),
}

SPEND_PREMIUM = {
    "spend_day": {
        100_000: [("3:500024", 1)],
        500_000: [("3:500024", 3), ("3:400023", 5)],
        1_000_000: [("3:500024", 5), ("3:400023", 10), ("3:500059", 1)],
        2_000_000: [("3:500024", 10), ("3:400023", 25), ("3:500059", 1)],
        3_000_000: [("3:400023", 40), ("3:500094", 1), ("3:500059", 2)],
        5_000_000: [("3:400023", 75), ("3:500094", 2), ("3:500059", 2), ("3:401001", 1), ("3:100231", 2), ("3:100232", 1)],
        10_000_000: [("3:400023", 150), ("3:500094", 4), ("3:500059", 4), ("3:401001", 2), ("3:100231", 5), ("3:100232", 2), ("3:100233", 1)],
    },
    "spend_week": {
        500_000: [("3:500024", 2), ("3:400023", 5)],
        1_000_000: [("3:500024", 4), ("3:400023", 10)],
        2_000_000: [("3:400023", 25), ("3:500059", 1)],
        5_000_000: [("3:400023", 60), ("3:500094", 1), ("3:500059", 2), ("3:100231", 3)],
        10_000_000: [("3:400023", 100), ("3:500094", 2), ("3:500059", 3), ("3:401001", 1), ("3:100231", 5), ("3:100232", 2)],
        20_000_000: [("3:400023", 180), ("3:500094", 4), ("3:500059", 5), ("3:401001", 3), ("3:100299", 6), ("3:100300", 3), ("3:100301", 1)],
        50_000_000: [("3:400023", 350), ("3:500094", 8), ("3:500059", 10), ("3:401001", 5), ("3:100302", 8), ("3:100303", 4), ("3:100304", 2), ("3:100318", 1), ("3:100319", 1)],
    },
    "spend_month": {
        200_000: [("3:500024", 2)],
        500_000: [("3:500024", 5), ("3:400023", 10)],
        1_000_000: [("3:500024", 8), ("3:400023", 25), ("3:500059", 1)],
        2_000_000: [("3:400023", 50), ("3:500094", 1), ("3:500059", 2), ("3:401001", 1)],
        5_000_000: [("3:400023", 120), ("3:500094", 3), ("3:500059", 4), ("3:401001", 2), ("3:100299", 5), ("3:100300", 2)],
        10_000_000: [("3:400023", 200), ("3:500094", 5), ("3:500059", 6), ("3:401001", 4), ("3:100302", 8), ("3:100303", 4), ("3:100304", 2)],
        20_000_000: [("3:400023", 350), ("3:500094", 10), ("3:500059", 12), ("3:401001", 7), ("3:110112", 8), ("3:110113", 4), ("3:110114", 2), ("3:100326", 1)],
        50_000_000: [("3:400023", 700), ("3:500094", 20), ("3:500059", 24), ("3:401001", 14), ("3:110112", 16), ("3:110113", 8), ("3:110114", 4), ("3:100320", 2), ("3:100321", 2), ("3:100506", 2)],
    },
    "spend_all": {
        50_000: [("3:500024", 1)],
        100_000: [("3:500024", 3), ("3:400023", 5)],
        200_000: [("3:500024", 5), ("3:400023", 15), ("3:500059", 1)],
        500_000: [("3:500024", 10), ("3:400023", 40), ("3:500059", 2), ("3:401001", 1)],
        1_000_000: [("3:400023", 80), ("3:500094", 2), ("3:500059", 4), ("3:401001", 2), ("3:100231", 5), ("3:100232", 2)],
        2_000_000: [("3:400023", 150), ("3:500094", 4), ("3:500059", 6), ("3:401001", 4), ("3:100299", 8), ("3:100300", 4), ("3:100301", 2)],
        5_000_000: [("3:400023", 300), ("3:500094", 8), ("3:500059", 10), ("3:401001", 6), ("3:100302", 12), ("3:100303", 6), ("3:100304", 3), ("3:100318", 1), ("3:100319", 1)],
        10_000_000: [("3:400023", 500), ("3:500094", 15), ("3:500059", 18), ("3:401001", 10), ("3:110112", 15), ("3:110113", 8), ("3:110114", 4), ("3:100326", 2), ("3:100506", 2)],
        20_000_000: [("3:400023", 900), ("3:500094", 25), ("3:500059", 30), ("3:401001", 18), ("3:110112", 25), ("3:110113", 12), ("3:110114", 7), ("3:100320", 3), ("3:100321", 3), ("3:100326", 4), ("3:100506", 4)],
        50_000_000: [("3:400023", 1_800), ("3:500094", 50), ("3:500059", 60), ("3:401001", 35), ("3:110112", 50), ("3:110113", 25), ("3:110114", 15), ("3:100320", 7), ("3:100321", 7), ("3:100326", 10), ("3:100506", 10)],
    },
}

ONLINE_REWARDS = {
    900: [("0:0", 200_000), ("0:4", 200_000), ("3:100342", 10), ("3:100216", 2_000)],
    1800: [("0:0", 400_000), ("0:4", 400_000), ("3:100252", 10), ("3:100253", 20), ("3:100004", 2_000)],
    3600: [("0:0", 800_000), ("0:4", 800_000), ("3:100001", 2_000), ("3:100342", 25), ("3:100216", 5_000)],
    7200: [("0:0", 1_500_000), ("0:4", 1_500_000), ("3:100096", 10), ("3:100001", 4_000), ("5:20001", 1), ("3:100004", 8_000)],
    14400: [("0:0", 3_000_000), ("0:4", 3_000_000), ("3:100096", 25), ("3:100001", 8_000), ("3:100342", 100), ("3:100252", 100), ("3:100253", 150), ("3:400023", 1)],
    21600: [("0:0", 5_000_000), ("0:4", 5_000_000), ("3:100096", 50), ("3:100001", 15_000), ("5:20001", 3), ("3:100258", 2), ("3:400023", 3), ("3:500024", 1)],
    28800: [("0:0", 8_000_000), ("0:4", 8_000_000), ("3:100096", 100), ("3:100146", 10), ("3:100001", 25_000), ("3:100342", 300), ("3:100252", 300), ("3:100253", 500), ("5:20001", 5), ("3:100258", 5), ("3:400023", 10), ("3:500024", 3)],
}


def gift_json(rewards: list[tuple[str, int]], item_map: dict[str, dict]) -> str:
    gifts = []
    for code, amount in rewards:
        meta = RESOURCE_META[code] if code in RESOURCE_META else item_map[code]
        gifts.append({"id": code, "name": meta["name"], "amount": str(amount), "icon": str(meta["icon"])})
    return sql_text(json.dumps(gifts, ensure_ascii=False, separators=(",", ":")))


def append_event(lines: list[str], event_type: str, name: str, info: str, prefix: str, suffix: str, tiers: list[int], rewards_by_need: dict[int, list[tuple[str, int]]], item_map: dict[str, dict], index: int) -> None:
    var = f"@engagement_{index}"
    lines.extend([
        "INSERT INTO `ny_event` (`name`,`info`,`type`,`icon`,`milestone_type`,`comparison`,`prefix`,`suffix`,`expires_time`,`display`,`update_time`)",
        f"SELECT '{sql_text(name)}','{sql_text(info)}','{event_type}',NULL,'money','>=','{prefix}','{suffix}',0,1,UNIX_TIMESTAMP() WHERE NOT EXISTS (SELECT 1 FROM `ny_event` WHERE `type`='{event_type}');",
        f"UPDATE `ny_event` SET `name`='{sql_text(name)}',`info`='{sql_text(info)}',`comparison`='>=',`prefix`='{prefix}',`suffix`='{suffix}',`expires_time`=0,`display`=1,`update_time`=UNIX_TIMESTAMP() WHERE `type`='{event_type}';",
        f"SET {var}=(SELECT `id` FROM `ny_event` WHERE `type`='{event_type}' ORDER BY `id` LIMIT 1);",
        f"DELETE FROM `ny_event_milestone` WHERE `event_id`={var} AND `need` NOT IN ({','.join(map(str, tiers))});", "",
    ])
    for need in tiers:
        payload = gift_json(rewards_by_need[need], item_map)
        lines.extend([
            "INSERT INTO `ny_event_milestone` (`event_id`,`need`,`gifts`)",
            f"SELECT {var},{need},'{payload}' WHERE NOT EXISTS (SELECT 1 FROM `ny_event_milestone` WHERE `event_id`={var} AND `need`={need});",
            f"UPDATE `ny_event_milestone` SET `gifts`='{payload}' WHERE `event_id`={var} AND `need`={need};", "",
        ])


def main() -> None:
    catalog = json.loads(CATALOG_PATH.read_text(encoding="utf-8"))
    item_map = {item["reward"]: item for item in catalog["items"]}
    lines = [
        "START TRANSACTION;", "",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `spend_week` DOUBLE(50,0) DEFAULT 0 AFTER `spend_day`;",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `online_day` INT(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `week_year`;",
        "ALTER TABLE `ny_user` ADD COLUMN IF NOT EXISTS `online_last_ping` INT(11) UNSIGNED NOT NULL DEFAULT 0 AFTER `online_day`;",
        "UPDATE `ny_user` SET `spend_week`=`spend_day` WHERE `spend_week`=0 AND `spend_day`>0;",
        "UPDATE `ny_event` SET `display`=0 WHERE `type`='login_day';", "",
    ]
    index = 1
    for event_type, (name, info, tiers, factor) in SPEND_EVENTS.items():
        rewards = {need: core_rewards(need, factor) + SPEND_PREMIUM[event_type].get(need, []) for need in tiers}
        append_event(lines, event_type, name, info, "Tiêu", "Xu", tiers, rewards, item_map, index)
        index += 1
    append_event(lines, "online_day", "Quà Online Theo Giờ", "Tích lũy khi tài khoản hoạt động liên tục; làm mới mỗi ngày.", "Online", "", list(ONLINE_REWARDS), ONLINE_REWARDS, item_map, index)
    lines.extend(["COMMIT;", ""])
    OUTPUT.write_text("\n".join(lines), encoding="utf-8")
    print(f"Built {sum(len(v[2]) for v in SPEND_EVENTS.values()) + len(ONLINE_REWARDS)} engagement milestones -> {OUTPUT}")


if __name__ == "__main__":
    main()
