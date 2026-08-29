"""Fix obviously wrong/missing hero voices by mapping variants to sane base voices.

Pass 1 intentionally avoids changing every normal hero voice. It fixes:
- variant heroes with empty voice fields;
- variant heroes referencing missing py_*.mp3 files;
- their skill voice references when the source is missing/variant-only.
"""

from __future__ import annotations

import csv
import re
import shutil
from pathlib import Path

from extract_game_catalog import ROOT, SOURCE, read_tables, to_rows
from patch_game_item_names import write_tables


SOUND_DIR = ROOT / "home/web/game/source/sound"
REPORT = ROOT / "home/web/game/source/template/hero_voice_gender_pass1_20260811.csv"
BACKUP = SOURCE.with_name("templates.bin.before-hero-voice-gender-pass1-20260811.bak")


# proto_id -> (target voice prefix, group note)
# Picked by hero identity/gender:
# - female variants use a female voice family;
# - male warrior/strategist variants use matching original hero family.
VOICE_MAP: dict[str, tuple[str, str]] = {
    "600100": ("401400", "nam - Triệu Vân dùng voice Triệu Vân"),
    "600200": ("302300", "nam mưu sĩ - Quách Gia dùng voice Quách Gia"),
    "600300": ("202500", "nam mưu sĩ - Gia Cát Lượng dùng voice Gia Cát Lượng"),
    "600400": ("201800", "nam võ tướng - Trương Phi dùng voice nam trầm"),
    "600500": ("500700", "nữ - Chân Mật dùng voice nữ Chân Cơ"),
    "600600": ("102000", "nam - Cam Ninh dùng voice Cam Ninh"),
    "600700": ("201800", "nam võ tướng - Quan Vũ dùng voice Quan Vũ"),
    "600800": ("500800", "nữ chiến - Trương Doanh Doanh dùng voice Lữ Linh Khởi"),
    "600900": ("302200", "nam Ngụy - Tào Hồng dùng voice Tào Tháo"),
    "601000": ("401700", "nam mạnh - Lữ Bố dùng voice Lữ Bố"),
}


def existing_files() -> set[str]:
    return {path.name for path in SOUND_DIR.iterdir() if path.is_file()}


def best_skill_voice(prefix: str, suffix: str, files: set[str]) -> str:
    candidates = [
        f"{prefix}_vc_{suffix}.wav",
        f"{prefix}_vc_{suffix}.mp3",
        f"{prefix}_vc_s1.wav",
        f"{prefix}_vc_s1.mp3",
    ]
    for candidate in candidates:
        if candidate in files:
            return candidate
    return ""


def skill_suffix(value: str) -> str:
    match = re.search(r"_vc_(s\d+)", value or "")
    if match:
        return match.group(1)
    return "s1"


def main() -> None:
    files = existing_files()
    missing_target = []
    for prefix, _note in VOICE_MAP.values():
        if f"{prefix}_vc_dlg.wav" not in files:
            missing_target.append(f"{prefix}_vc_dlg.wav")
        if not best_skill_voice(prefix, "s1", files):
            missing_target.append(f"{prefix}_vc_s1.wav/mp3")
    if missing_target:
        raise RuntimeError("Missing target voice files: " + ", ".join(sorted(set(missing_target))))

    if not BACKUP.exists():
        shutil.copy2(SOURCE, BACKUP)

    tables = read_tables(SOURCE.read_bytes())
    text_rows = to_rows(tables["文本库"])
    text_map = {row["ID"]: row["目标文本"] for row in text_rows}

    hero_rows = tables["英雄基础"]
    hero_headers = hero_rows[0]
    hi = {name: hero_headers.index(name) for name in hero_headers}
    report_rows: list[dict[str, str]] = []
    patched_heroes = 0

    for row in hero_rows[1:]:
        if not row:
            continue
        proto = row[hi["原型ID"]]
        patch = VOICE_MAP.get(proto)
        if not patch:
            continue
        prefix, note = patch
        old = row[hi["语音"]]
        new = f"{prefix}_vc_dlg.wav"
        if old != new:
            row[hi["语音"]] = new
            patched_heroes += 1
        report_rows.append(
            {
                "hero_id": row[hi["英雄ID"]],
                "proto_id": proto,
                "name": text_map.get(row[hi["英雄名YID"]], row[hi["英雄名YID"]]),
                "old_voice": old,
                "new_voice": new,
                "note": note,
            }
        )

    skill_rows = tables["英雄技能"]
    skill_headers = skill_rows[0]
    si = {name: skill_headers.index(name) for name in skill_headers}
    patched_skills = 0
    for row in skill_rows[1:]:
        if not row:
            continue
        proto = row[si["原型ID"]]
        patch = VOICE_MAP.get(proto)
        if not patch:
            continue
        old = row[si["技能语音资源"]]
        if not old or old == "0":
            continue
        prefix, _note = patch
        new = best_skill_voice(prefix, skill_suffix(old), files)
        if new and old != new:
            row[si["技能语音资源"]] = new
            patched_skills += 1

    SOURCE.write_bytes(write_tables(tables))
    REPORT.parent.mkdir(parents=True, exist_ok=True)
    with REPORT.open("w", newline="", encoding="utf-8-sig") as f:
        writer = csv.DictWriter(f, fieldnames=["hero_id", "proto_id", "name", "old_voice", "new_voice", "note"])
        writer.writeheader()
        writer.writerows(report_rows)

    print(f"Patched hero voice rows: {patched_heroes}")
    print(f"Patched skill voice rows: {patched_skills}")
    print(f"Report: {REPORT}")
    print(f"Backup: {BACKUP}")


if __name__ == "__main__":
    main()
