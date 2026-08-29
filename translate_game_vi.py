from __future__ import annotations

import argparse
import json
import pathlib
import re
import shutil
import time
import zlib

import requests

from audit_game_localization import HAN_RE, parse_tables


VISIBLE_HEADER_TERMS = (
    "名称",
    "名字",
    "描述",
    "说明",
    "备注",
    "标题",
    "文本",
    "广告语",
    "寄语",
    "方位",
    "区域",
    "章节名",
    "怪物名",
    "城池名",
    "任务描述",
    "奖励详情",
    "上联",
    "下联",
    "标签",
    "阵营",
    "类型说明",
)

EXCLUDED_TABLES = {
    "屏蔽字库",  # Chat filter dictionary, never rendered to the player.
    "皮肤技能特效替换",  # Internal effect lookup values.
}

EXCLUDED_HEADER_TERMS = (
    "ID",
    "资源",
    "脚本",
    "配置",
    "检测操作",
    "关联",
    "对照",
    "参数",
)

PROTECTED_RE = re.compile(
    r"<[^>]*>|\{[^{}]*\}|%\d*\$?[sdif]|https?://\S+|\\[nrt]|\[\[\[[A-Z]+\d+\]\]\]"
)

MANUAL_TRANSLATIONS = {
    "金币": "Vàng",
    "英雄经验": "Kinh nghiệm anh hùng",
    "进阶石": "Đá tăng bậc",
    "高级点将券": "Vé Chiêu Mộ Cao Cấp",
    "高级点将卷": "Vé Chiêu Mộ Cao Cấp",
    "普通点将券": "Vé Chiêu Mộ Thường",
    "法力滋养": "Bồi dưỡng pháp lực",
    "免伤提升": "Tăng miễn thương",
    "九天玄女": "Cửu Thiên Huyền Nữ",
    "玉帝": "Ngọc Hoàng",
    "孟婆": "Mạnh Bà",
    "花木兰": "Hoa Mộc Lan",
    "烛龙": "Chúc Long",
    "西王母": "Tây Vương Mẫu",
    "杨戬": "Dương Tiễn",
    "刑天": "Hình Thiên",
    "嫦娥": "Hằng Nga",
    "妲己": "Đát Kỷ",
    "<2011 通过><2010 {s}><2011 关送一星红武>": "<2011 Vượt><2010 {s}><2011 ải nhận Vũ khí Đỏ 1 sao>",
    "<2011 通过><2010 {s}><2011 关送妲己>": "<2011 Vượt><2010 {s}><2011 ải nhận Đát Kỷ>",
    "<2011 通过><2010 {s}><2011 关送进阶石>": "<2011 Vượt><2010 {s}><2011 ải nhận Đá Tăng Bậc>",
    "仙器置换第149期": "Đổi Tiên Khí - Đợt 149",
    "可激活刑天稀有皮肤：<2408 光耀战神（永久）>，并解锁相应<2405 冒险形象>和<2405 头像装饰>；激活皮肤（无需穿戴）即可为对应英雄增加属性，同一英雄的多套<2405 皮肤属性可以叠加>": "Có thể kích hoạt trang phục hiếm của Hình Thiên: <2408 Chiến Thần Quang Diệu (vĩnh viễn)>, đồng thời mở khóa <2405 Hình đại diện phiêu lưu> và <2405 Trang trí ảnh đại diện>; kích hoạt trang phục (không cần mặc) sẽ tăng thuộc tính cho anh hùng, nhiều trang phục của cùng anh hùng có <2405 thuộc tính cộng dồn>",
    "可激活杨戬稀有皮肤：<2408 战神机甲（永久）>，并解锁相应<2405 冒险形象>和<2405 头像装饰>；激活皮肤（无需穿戴）即可为对应英雄增加属性，同一英雄的多套<2405 皮肤属性可以叠加>": "Có thể kích hoạt trang phục hiếm của Dương Tiễn: <2408 Chiến Thần Giáp Máy (vĩnh viễn)>, đồng thời mở khóa <2405 Hình đại diện phiêu lưu> và <2405 Trang trí ảnh đại diện>; kích hoạt trang phục (không cần mặc) sẽ tăng thuộc tính cho anh hùng, nhiều trang phục của cùng anh hùng có <2405 thuộc tính cộng dồn>",
    "可激活西王母稀有皮肤：<2408 粉红天使（永久）>，并解锁相应<2405 冒险形象>和<2405 头像装饰>；激活皮肤（无需穿戴）即可为对应英雄增加属性，同一英雄的多套<2405 皮肤属性可以叠加>": "Có thể kích hoạt trang phục hiếm của Tây Vương Mẫu: <2408 Thiên Sứ Hồng (vĩnh viễn)>, đồng thời mở khóa <2405 Hình đại diện phiêu lưu> và <2405 Trang trí ảnh đại diện>; kích hoạt trang phục (không cần mặc) sẽ tăng thuộc tính cho anh hùng, nhiều trang phục của cùng anh hùng có <2405 thuộc tính cộng dồn>",
    "可激活称号：<2408 《无限至尊》>，<br>称号属性：<2405 生命+3%，攻击+3%>": "Có thể kích hoạt danh hiệu: <2408 《Chí Tôn Vô Hạn》>, <br>Thuộc tính danh hiệu: <2405 Sinh lực +3%, Tấn công +3%>",
    "可激活聊天标签：<2408 《无限至尊》>": "Có thể kích hoạt thẻ trò chuyện: <2408 《Chí Tôn Vô Hạn》>",
    "地-别情离恨": "Địa - Biệt Tình Ly Hận",
    "天-墨杆金钩": "Thiên - Mặc Can Kim Câu",
    "天-夜郎天书": "Thiên - Dạ Lang Thiên Thư",
    "天-洛神花": "Thiên - Hoa Lạc Thần",
    "天-秋水人家": "Thiên - Thu Thủy Nhân Gia",
    "天-龙胆亮银枪": "Thiên - Thương Ngân Long Đảm",
    "天·月华": "Thiên · Nguyệt Hoa",
    "天·龙王篓": "Thiên · Giỏ Long Vương",
    "嫗姬": "Ngự Cơ",
    "嫗姬*1": "Ngự Cơ*1",
    "完美阵容，由你打造": "Đội hình hoàn hảo, do bạn tạo dựng",
    "巽": "Tốn",
    "打开后可以获得以下道具:<2608 高级点将卷*10>": "Mở ra nhận được các vật phẩm sau: <2608 Vé Chiêu Mộ Cao Cấp*10>",
}


def is_visible_column(table: str, header: str) -> bool:
    if table in EXCLUDED_TABLES:
        return False
    if any(term in header for term in EXCLUDED_HEADER_TERMS):
        return False
    return any(term in header for term in VISIBLE_HEADER_TERMS)


def encode_utf_string(value: str) -> bytes:
    raw = value.encode("utf-8")
    if len(raw) > 65535:
        raise ValueError(f"UTF value is too long: {len(raw)} bytes")
    return len(raw).to_bytes(2, "big") + raw


def serialize_tables(tables: list[tuple[str, list[list[str]]]]) -> bytes:
    output = bytearray()
    for name, rows in tables:
        output.extend(encode_utf_string(name))
        output.extend(len(rows).to_bytes(4, "big", signed=True))
        for row in rows:
            row_data = b"".join(encode_utf_string(value) for value in row)
            if len(row_data) > 32767:
                raise ValueError(f"Row in table {name!r} is too long: {len(row_data)} bytes")
            output.extend(len(row_data).to_bytes(2, "big", signed=True))
            output.extend(row_data)
    return bytes(output)


class GoogleTranslator:
    endpoint = "https://translate.googleapis.com/translate_a/single"

    def __init__(self, cache_path: pathlib.Path, use_local: bool = False) -> None:
        self.cache_path = cache_path
        self.use_local = use_local
        self.session = requests.Session()
        if cache_path.exists():
            self.cache: dict[str, str] = json.loads(cache_path.read_text(encoding="utf-8"))
        else:
            self.cache = {}
        self.cache.update(MANUAL_TRANSLATIONS)

    @staticmethod
    def translate_local(text: str) -> str:
        from argostranslate import translate

        return translate.translate(text, "zh", "vi")

    def save(self) -> None:
        self.cache_path.write_text(
            json.dumps(self.cache, ensure_ascii=False, indent=2, sort_keys=True),
            encoding="utf-8",
        )

    @staticmethod
    def protect(value: str, item_index: int) -> tuple[str, dict[str, str]]:
        replacements: dict[str, str] = {}

        def replace(match: re.Match[str]) -> str:
            marker = f"[[[KEEP{item_index:04d}{len(replacements):04d}]]]"
            replacements[marker] = match.group(0)
            return marker

        return PROTECTED_RE.sub(replace, value), replacements

    @staticmethod
    def restore(value: str, replacements: dict[str, str]) -> str:
        for marker, original in replacements.items():
            value = value.replace(marker, original)
        return value

    def request(self, text: str) -> str:
        payload = {"client": "gtx", "sl": "zh-CN", "tl": "vi", "dt": "t", "q": text}
        last_error: Exception | None = None
        for attempt in range(5):
            try:
                response = self.session.post(self.endpoint, data=payload, timeout=40)
                response.raise_for_status()
                return "".join(part[0] for part in response.json()[0])
            except Exception as error:  # Network service can transiently throttle.
                last_error = error
                time.sleep(2**attempt)
        raise RuntimeError(f"Translation request failed after 5 attempts: {last_error}")

    def translate_batch(self, values: list[str]) -> None:
        protected_values: list[str] = []
        replacements: list[dict[str, str]] = []
        for index, value in enumerate(values):
            protected, mapping = self.protect(value, index)
            protected_values.append(protected)
            replacements.append(mapping)

        if self.use_local:
            for index, source_value in enumerate(values):
                result = self.translate_local(protected_values[index])
                result = self.restore(result, replacements[index]).strip()
                if not result:
                    raise ValueError(f"Empty local translation for {source_value!r}")
                self.cache[source_value] = result
            return

        source = "\n".join(
            f"[[[ITEM{index:04d}]]]{value}" for index, value in enumerate(protected_values)
        )
        translated = self.request(source)
        matches = list(re.finditer(r"\[\[\[ITEM(\d{4})\]\]\]", translated))
        parsed: dict[int, str] = {}
        for pos, match in enumerate(matches):
            start = match.end()
            end = matches[pos + 1].start() if pos + 1 < len(matches) else len(translated)
            parsed[int(match.group(1))] = translated[start:end].strip("\r\n")

        if len(parsed) != len(values):
            raise ValueError(f"Expected {len(values)} translated items, received {len(parsed)}")

        for index, source_value in enumerate(values):
            result = self.restore(parsed[index], replacements[index]).strip()
            if not result:
                raise ValueError(f"Empty translation for {source_value!r}")
            self.cache[source_value] = result

    def translate_all(self, values: set[str]) -> None:
        pending = sorted((value for value in values if value not in self.cache), key=len)
        print(f"translation_cache={len(self.cache)} pending={len(pending)}")
        processed = 0
        while pending:
            batch: list[str] = []
            char_count = 0
            while pending and len(batch) < 30:
                candidate = pending[0]
                if batch and char_count + len(candidate) > 3500:
                    break
                pending.pop(0)
                batch.append(candidate)
                char_count += len(candidate)
            try:
                self.translate_batch(batch)
            except ValueError:
                for value in batch:
                    self.translate_batch([value])
            processed += len(batch)
            self.save()
            print(f"translated={processed} remaining={len(pending)}")
            time.sleep(0.15)


def collect_template_values(tables: list[tuple[str, list[list[str]]]]) -> set[str]:
    values: set[str] = set()
    for table, rows in tables:
        if not rows:
            continue
        headers = rows[0]
        for row in rows[1:]:
            for index, value in enumerate(row):
                header = headers[index] if index < len(headers) else ""
                if is_visible_column(table, header) and HAN_RE.search(value):
                    values.add(value)
    return values


def translate_templates(
    path: pathlib.Path,
    translator: GoogleTranslator,
    apply_changes: bool,
    rebuild_from_backup: bool = False,
) -> tuple[int, int]:
    backup = path.with_suffix(path.suffix + ".before-vi.bak")
    source_path = backup if rebuild_from_backup and backup.exists() else path
    packed = source_path.read_bytes()
    unpacked = zlib.decompress(packed)
    tables = parse_tables(unpacked)
    values = collect_template_values(tables)
    translator.translate_all(values)

    replacements = 0
    for table, rows in tables:
        if not rows:
            continue
        headers = rows[0]
        for row in rows[1:]:
            for index, value in enumerate(row):
                header = headers[index] if index < len(headers) else ""
                if is_visible_column(table, header) and value in translator.cache and HAN_RE.search(value):
                    row[index] = translator.cache[value]
                    replacements += 1

    rebuilt = serialize_tables(tables)
    reparsed = parse_tables(rebuilt)
    if len(reparsed) != len(tables):
        raise ValueError("Rebuilt template table count does not match source")
    remaining = len(collect_template_values(reparsed))
    if apply_changes:
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_bytes(zlib.compress(rebuilt, level=9))
    return replacements, remaining


def translate_text_file(
    path: pathlib.Path, translator: GoogleTranslator, apply_changes: bool
) -> tuple[int, int]:
    content = path.read_text(encoding="utf-8")
    lines = content.splitlines(keepends=True)
    values = {line.strip() for line in lines if HAN_RE.search(line) and line.strip()}
    translator.translate_all(values)
    translated_lines: list[str] = []
    replacements = 0
    for line in lines:
        bare = line.strip()
        if bare in translator.cache and HAN_RE.search(bare):
            leading = line[: len(line) - len(line.lstrip())]
            ending = "\r\n" if line.endswith("\r\n") else "\n" if line.endswith("\n") else ""
            translated_lines.append(leading + translator.cache[bare] + ending)
            replacements += 1
        else:
            translated_lines.append(line)
    result = "".join(translated_lines)
    remaining = len(HAN_RE.findall(result))
    if apply_changes:
        backup = path.with_suffix(path.suffix + ".before-vi.bak")
        if not backup.exists():
            shutil.copy2(path, backup)
        path.write_text(result, encoding="utf-8")
    return replacements, remaining


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--apply", action="store_true")
    parser.add_argument(
        "--template",
        type=pathlib.Path,
        default=pathlib.Path("home/web/game/source/template/templates.bin"),
    )
    parser.add_argument(
        "--cache",
        type=pathlib.Path,
        default=pathlib.Path("translation_cache_vi.json"),
    )
    parser.add_argument("--skip-legal", action="store_true")
    parser.add_argument("--skip-template", action="store_true")
    parser.add_argument("--local", action="store_true")
    parser.add_argument("--rebuild-template-from-backup", action="store_true")
    args = parser.parse_args()

    translator = GoogleTranslator(args.cache, use_local=args.local)
    if not args.skip_template:
        replacements, remaining = translate_templates(
            args.template,
            translator,
            args.apply,
            rebuild_from_backup=args.rebuild_template_from_backup,
        )
        print(f"template_replacements={replacements} remaining_visible_han_values={remaining}")

    if not args.skip_legal:
        utility = pathlib.Path("home/web/game/source/utility")
        for name in ("游戏用户协议10091.txt", "游戏隐私政策10091.txt", "适龄提示16.txt"):
            path = utility / name
            count, han_count = translate_text_file(path, translator, args.apply)
            print(f"legal_file={name} replacements={count} remaining_han_chars={han_count}")

    if not args.apply:
        print("Dry run only. Run again with --apply to write translated files.")
    translator.save()


if __name__ == "__main__":
    main()
