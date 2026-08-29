from __future__ import annotations

import json
import shutil
from pathlib import Path

from extract_game_catalog import ROOT, SOURCE, read_tables
from patch_game_item_names import write_tables


BACKUP = SOURCE.with_name("templates.bin.before-topup-tiers-vnd-20260811.bak")
ID_TXT = ROOT / "home/web/api/id.txt"
PAY_JSON = ROOT / "home/web/game/source/srv/excel/充值项.json"

TIERS = [
    ("1", "Nạp 20.000 VNĐ", "20000"),
    ("2", "Nạp 50.000 VNĐ", "50000"),
    ("3", "Nạp 100.000 VNĐ", "100000"),
    ("4", "Nạp 200.000 VNĐ", "200000"),
    ("5", "Nạp 500.000 VNĐ", "500000"),
    ("6", "Nạp 1.000.000 VNĐ", "1000000"),
    ("7", "Nạp 2.000.000 VNĐ", "2000000"),
    ("8", "Nạp 5.000.000 VNĐ", "5000000"),
    ("9", "Nạp 10.000.000 VNĐ", "10000000"),
    ("10", "Nạp 50.000.000 VNĐ", "50000000"),
]


def read_id_txt() -> dict[str, str]:
    mapping: dict[str, str] = {}
    if ID_TXT.exists():
        for line in ID_TXT.read_text(encoding="utf-8").splitlines():
            if ";" not in line:
                continue
            key, value = line.split(";", 1)
            if key.strip():
                mapping[key.strip()] = value.strip()
    return mapping


def write_id_txt(mapping: dict[str, str]) -> None:
    def sort_key(value: str) -> int:
        return int(value) if value.isdigit() else 10**12

    ID_TXT.write_text("\n".join(f"{key};{mapping[key]}" for key in sorted(mapping, key=sort_key)) + "\n", encoding="utf-8")


def main() -> None:
    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    tables = read_tables(SOURCE.read_bytes())
    pay_rows = tables["付费充值"]
    pay_headers = pay_rows[0]
    pay_by_id = {row[pay_headers.index("ID")]: row for row in pay_rows[1:]}

    charge_amount: dict[str, str] = {}
    for tier_id, name, amount in TIERS:
        row = pay_by_id[tier_id]
        row[pay_headers.index("名称")] = name
        row[pay_headers.index("价格")] = amount
        row[pay_headers.index("基础元宝")] = amount
        row[pay_headers.index("首冲赠送元宝")] = amount
        charge_amount[row[pay_headers.index("充值项ID")]] = amount

    charge_rows = tables["充值项"]
    charge_headers = charge_rows[0]
    id_i = charge_headers.index("ID")
    amount_i = charge_headers.index("额度")
    for row in charge_rows[1:]:
        charge_id = row[id_i]
        if charge_id in charge_amount:
            row[amount_i] = charge_amount[charge_id]

    SOURCE.write_bytes(write_tables(tables))

    id_map = read_id_txt()
    for charge_id, amount in charge_amount.items():
        id_map[charge_id] = amount
    write_id_txt(id_map)

    if PAY_JSON.exists():
        payload = json.loads(PAY_JSON.read_text(encoding="utf-8"))
        by_id = {str(row.get("id")): row for row in payload.get("data", [])}
        for charge_id, amount in charge_amount.items():
            row = by_id.get(charge_id)
            if row is None:
                continue
            value = int(amount)
            row["rmb"] = value / 1000
            row["vipPoints"] = value // 100
        PAY_JSON.write_text(json.dumps(payload, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")

    print("Top-up tiers normalized:")
    for tier_id, name, amount in TIERS:
        print(f"  {tier_id}: {name} => {amount} KNB + first bonus {amount} KNB")
    print(f"Backup: {BACKUP}")


if __name__ == "__main__":
    main()
