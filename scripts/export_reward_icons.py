"""Export the real game textures used by web recharge rewards."""

from __future__ import annotations

import json
import shutil
import zlib
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
GAME_SOURCE = ROOT / "home/web/game/source"
MANIFEST = ROOT / "home/web/api/arial.ttf"
OUTPUT = ROOT / "home/web/client/images/icon"

ITEM_ICON_IDS = {
    "999999", "10013", "10016", "10041", "10045", "10077", "10091",
    "10114", "10247", "10330", "10331", "10332", "10333", "10334",
    "10335", "10349", "10351", "10352", "10353", "10355", "10356",
    "10357", "10358", "10359", "10360", "10361", "10362", "10363",
    "10364", "10375", "10377", "10378", "10379", "10505", "10506",
    "10509", "10510", "10514", "10516", "10539", "10542", "10543",
    "10544", "50048", "50049", "65009", "65010", "65011", "65018",
}

SPECIAL_ICONS = {"FW10117": "icon/FW10117.png"}


def main() -> None:
    manifest = json.loads(zlib.decompress(MANIFEST.read_bytes()))
    logical_icons = {icon: f"icon/item{icon}.png" for icon in ITEM_ICON_IDS}
    logical_icons.update(SPECIAL_ICONS)
    OUTPUT.mkdir(parents=True, exist_ok=True)

    exported = 0
    for output_name, logical_path in sorted(logical_icons.items()):
        packed_path = manifest.get(logical_path)
        if not packed_path:
            raise RuntimeError(f"Missing resource mapping for {logical_path}")
        source = GAME_SOURCE / packed_path
        data = source.read_bytes()
        if not data.startswith(b"\x89PNG\r\n\x1a\n"):
            raise RuntimeError(f"Mapped resource is not PNG: {source}")
        shutil.copyfile(source, OUTPUT / f"{output_name}.png")
        exported += 1

    print(f"Exported {exported} real reward icons -> {OUTPUT}")


if __name__ == "__main__":
    main()
