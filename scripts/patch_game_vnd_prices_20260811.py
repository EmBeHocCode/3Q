"""Normalize all in-game VNĐ package prices and billing ids.

The game has many legacy RMB-like package prices (6/30/128/328/648) plus
old tiny VNĐ values (3k/15k). This script normalizes visible template prices,
the template recharge-id amount table, API id.txt, and srv/excel/充值项.json.
"""

from __future__ import annotations

import json
import re
import shutil
from pathlib import Path

from extract_game_catalog import ROOT, SOURCE, read_tables
from patch_game_item_names import write_tables


BACKUP = SOURCE.with_name("templates.bin.before-vnd-prices-20260811.bak")
ID_TXT = ROOT / "home/web/api/id.txt"
PAY_JSON = ROOT / "home/web/game/source/srv/excel/充值项.json"


PRICE_FIELD_PRIORITY = [
    "价格",
    "人民币价格",
    "打折价格",
    "付费礼包价格",
    "追加奖励价格",
    "进阶赠礼价格",
    "人民币消耗",
    "红包金额",
]

SPECIAL_CHARGE_PRICE = {
    "优惠价格充值项ID": "打折价格",
    "初级契约充值项ID": "初级契约价格",
    "高级契约充值项ID": "高级契约价格",
}

EXCLUDE_PRICE_FIELDS = {"元宝价格", "元宝购买价格", "优惠价格充值项ID"}


def is_int(value: str) -> bool:
    return bool(re.fullmatch(r"\d+", value or ""))


def normalize_vnd(raw: str) -> str:
    if not is_int(raw) or int(raw) <= 0:
        return raw
    value = int(raw)
    # Legacy RMB-like prices.
    if value < 1000:
        if value <= 12:
            return "20000"
        if value <= 30:
            return "50000"
        if value <= 68:
            return "100000"
        if value <= 128:
            return "200000"
        if value <= 198:
            return "300000"
        if value <= 328:
            return "500000"
        if value <= 648:
            return "1000000"
        return "2000000"
    # Tiny legacy VNĐ prices are too cheap for current economy.
    if value < 20000:
        return "20000"
    return str(value)


def pick_price_field(headers: list[str], row: list[str], charge_field: str) -> str | None:
    special = SPECIAL_CHARGE_PRICE.get(charge_field)
    if special and special in headers:
        value = row[headers.index(special)]
        if is_int(value) and int(value) > 0:
            return special

    for field in PRICE_FIELD_PRIORITY:
        if field in EXCLUDE_PRICE_FIELDS or field not in headers:
            continue
        value = row[headers.index(field)]
        if is_int(value) and int(value) > 0:
            # If both 元宝价格 and 人民币价格 exist, an empty 人民币价格 means not VND.
            if field == "价格":
                # For rows with 元宝购买价格, 价格 is still VNĐ if a recharge id is present.
                pass
            return field
    return None


def read_id_txt() -> dict[str, str]:
    mapping: dict[str, str] = {}
    if not ID_TXT.exists():
        return mapping
    for line in ID_TXT.read_text(encoding="utf-8").splitlines():
        if ";" not in line:
            continue
        key, value = line.split(";", 1)
        key = key.strip()
        value = value.strip()
        if key:
            mapping[key] = value
    return mapping


def write_id_txt(mapping: dict[str, str]) -> None:
    lines = [f"{key};{mapping[key]}" for key in sorted(mapping, key=lambda x: int(x) if x.isdigit() else 10**12)]
    ID_TXT.write_text("\n".join(lines) + "\n", encoding="utf-8")


def main() -> None:
    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    tables = read_tables(SOURCE.read_bytes())
    charge_price: dict[str, str] = {}
    changed_template_prices = 0
    touched_tables: dict[str, int] = {}
    samples: list[str] = []

    for table_name, rows in tables.items():
        if not rows:
            continue
        headers = rows[0]
        charge_fields = [h for h in headers if "充值项" in h]
        if not charge_fields:
            continue
        for row in rows[1:]:
            if not row:
                continue
            for charge_field in charge_fields:
                charge_value = row[headers.index(charge_field)] if charge_field in headers else ""
                if not is_int(charge_value) or int(charge_value) <= 0:
                    continue
                price_field = pick_price_field(headers, row, charge_field)
                if not price_field:
                    continue
                price_index = headers.index(price_field)
                old_price = row[price_index]
                new_price = normalize_vnd(old_price)
                if not is_int(new_price) or int(new_price) <= 0:
                    continue
                charge_price[charge_value] = new_price
                if new_price != old_price:
                    row[price_index] = new_price
                    changed_template_prices += 1
                    touched_tables[table_name] = touched_tables.get(table_name, 0) + 1
                    if len(samples) < 16:
                        samples.append(f"{table_name}.{price_field} payid {charge_value}: {old_price} -> {new_price}")

    # 付费充值 prices are already VNĐ top-up tiers; ensure charge map includes them.
    for row in tables.get("付费充值", [])[1:]:
        headers = tables["付费充值"][0]
        price = row[headers.index("价格")]
        charge = row[headers.index("充值项ID")]
        if is_int(charge) and is_int(price):
            charge_price[charge] = price

    # Update template 充值项 table.
    updated_charge_table = 0
    if "充值项" in tables:
        headers = tables["充值项"][0]
        id_i = headers.index("ID")
        amount_i = headers.index("额度")
        existing = {row[id_i]: row for row in tables["充值项"][1:] if row}
        for charge, price in charge_price.items():
            row = existing.get(charge)
            if row is None:
                tables["充值项"].append([charge, price])
                updated_charge_table += 1
                continue
            if row[amount_i] != price:
                row[amount_i] = price
                updated_charge_table += 1

    SOURCE.write_bytes(write_tables(tables))

    # Update API id.txt.
    id_map = read_id_txt()
    id_updates = 0
    for charge, price in charge_price.items():
        if id_map.get(charge) != price:
            id_map[charge] = price
            id_updates += 1
    write_id_txt(id_map)

    # Update srv/excel/充值项.json.
    json_updates = 0
    if PAY_JSON.exists():
        payload = json.loads(PAY_JSON.read_text(encoding="utf-8"))
        by_id = {str(row.get("id")): row for row in payload.get("data", [])}
        for charge, price in charge_price.items():
            row = by_id.get(charge)
            if row is None:
                continue
            before = dict(row)
            amount = int(price)
            row["rmb"] = amount / 1000
            row["vipPoints"] = amount // 100
            json_updates += int(row != before)
        if json_updates:
            PAY_JSON.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")

    print(f"Normalized visible VNĐ price fields: {changed_template_prices}")
    print(f"Updated template 充值项 amounts: {updated_charge_table}")
    print(f"Updated api/id.txt entries: {id_updates}")
    print(f"Updated srv/excel/充值项.json rows: {json_updates}")
    print("Touched tables:")
    for table, count in sorted(touched_tables.items(), key=lambda item: (-item[1], item[0]))[:40]:
        print(f"  {table}: {count}")
    print("Samples:")
    for sample in samples:
        print(f"  {sample}")
    print(f"Backup: {BACKUP}")


if __name__ == "__main__":
    main()
