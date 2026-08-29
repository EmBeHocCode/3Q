from __future__ import annotations

import json
import pathlib
import shutil
import zlib


UI_BIN = pathlib.Path("home/web/game/source/ui/ui.bin")
BACKUP = UI_BIN.with_suffix(".bin.before-profile-fix.bak")


def walk(node: dict):
    yield node
    for child in node.get("child", []):
        yield from walk(child)


def find_var(scene: dict, name: str) -> dict:
    for node in walk(scene):
        if node.get("props", {}).get("var") == name:
            return node
    raise KeyError(f"Missing UI node: {name}")


def find_skin(scene: dict, skin: str) -> dict:
    for node in walk(scene):
        if node.get("props", {}).get("skin") == skin:
            return node
    raise KeyError(f"Missing UI skin: {skin}")


def replace_text(scene: dict, old: str, new: str) -> int:
    count = 0
    for node in walk(scene):
        props = node.get("props", {})
        if props.get("text") == old:
            props["text"] = new
            count += 1
    return count


def main() -> None:
    data = json.loads(zlib.decompress(UI_BIN.read_bytes()).decode("utf-8"))

    top_bar = data["TopBar"]
    find_skin(top_bar, "jin/vip.png")["props"].update(
        {"x": 17, "y": 73, "width": 100, "height": 30}
    )
    find_var(top_bar, "txtViplv")["props"].update(
        {
            "x": 17,
            "y": 75,
            "width": 100,
            "height": 26,
            "fontSize": 20,
            "align": "center",
            "italic": False,
            "bold": True,
            "stroke": 2,
        }
    )

    find_var(data["personalspace1"], "boxModel")["props"].update(
        {"y": 365, "mouseEnabled": False, "mouseThrough": True}
    )
    find_var(data["PersonalDecorate"], "boxModel")["props"].update(
        {"y": 315, "mouseEnabled": False, "mouseThrough": True}
    )

    login_notice = data["LoginNotice"]
    if replace_text(login_notice, "Thông cáo", "Thông báo") != 1:
        raise ValueError("Unexpected LoginNotice heading count")
    if replace_text(login_notice, "Xác định", "Xác nhận") != 1:
        raise ValueError("Unexpected LoginNotice confirm-label count")
    find_var(login_notice, "labTitle")["props"]["text"] = "Thông báo máy chủ Meow 3Q"

    rebuilt = json.dumps(data, ensure_ascii=False, separators=(",", ":")).encode("utf-8")
    if not BACKUP.exists():
        shutil.copy2(UI_BIN, BACKUP)
    UI_BIN.write_bytes(zlib.compress(rebuilt, level=9))

    verified = json.loads(zlib.decompress(UI_BIN.read_bytes()).decode("utf-8"))
    assert find_var(verified["TopBar"], "txtViplv")["props"]["x"] == 17
    assert find_var(verified["PersonalDecorate"], "boxModel")["props"]["y"] == 315
    assert find_var(verified["personalspace1"], "boxModel")["props"]["y"] == 365
    print(f"patched={UI_BIN} packed_bytes={UI_BIN.stat().st_size} scenes={len(verified)}")


if __name__ == "__main__":
    main()
