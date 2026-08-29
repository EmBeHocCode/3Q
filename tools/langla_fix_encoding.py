import os
import urllib.request

ROOTS = [
    r"C:\xampp\htdocs\langla",
    r"C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)",
]

EXTS = {".php", ".html", ".htm", ".css", ".js", ".txt", ".json", ".xml"}
BAD_MARKERS = [
    "\u00c3",  # Ã
    "\u00c2",  # Â
    "\u00c4",  # Ä
    "\u00c6",  # Æ
    "\u00a1",  # ¡ common after mojibake
    "\u00ba",  # º common after mojibake
    "\u00bb",  # » common after mojibake
    "\ufffd",  # replacement char
]


def bad_score(text: str) -> int:
    return sum(text.count(marker) for marker in BAD_MARKERS)


def read_text(path: str):
    data = open(path, "rb").read()
    if b"\x00" in data:
        return None
    for enc in ("utf-8-sig", "utf-8", "cp1252", "latin1"):
        try:
            return data.decode(enc)
        except UnicodeDecodeError:
            pass
    return None


def repair_mojibake(text: str) -> str:
    current = text
    for _ in range(4):
        best = current
        best_score = bad_score(current)
        for enc in ("cp1252", "latin1"):
            try:
                candidate = current.encode(enc).decode("utf-8")
            except Exception:
                continue
            score = bad_score(candidate)
            if score < best_score:
                best = candidate
                best_score = score
        if best == current:
            break
        current = best
    return current


patched = []
for root in ROOTS:
    if not os.path.isdir(root):
        print(f"MISSING_ROOT {root}")
        continue
    for dirpath, _, filenames in os.walk(root):
        for filename in filenames:
            ext = os.path.splitext(filename)[1].lower()
            if ext not in EXTS:
                continue
            path = os.path.join(dirpath, filename)
            text = read_text(path)
            if text is None:
                continue
            before = bad_score(text)
            fixed = repair_mojibake(text)
            after = bad_score(fixed)
            if fixed != text and after < before:
                open(path, "wb").write(fixed.encode("utf-8"))
                patched.append((path, before, after))

for path, before, after in patched:
    print(f"PATCHED {before}->{after} {path}")
print(f"TOTAL_PATCHED={len(patched)}")

URLS = [
    "http://127.0.0.1/langla/",
    "http://127.0.0.1/langla/login/",
    "http://127.0.0.1/langla/register/",
    "http://127.0.0.1/langla/bang-xep-hang/",
    "http://127.0.0.1/langla/tai-ve/",
]

print("=== SMOKE ===")
for url in URLS:
    try:
        with urllib.request.urlopen(url, timeout=8) as response:
            raw = response.read()
            body = raw.decode("utf-8", errors="replace")
            score = bad_score(body)
            has_error = any(x in body for x in ("Fatal error", "Warning", "Notice", "Undefined"))
            print(f"{url} status={response.status} len={len(raw)} bad_score={score} php_error={has_error}")
            if score or has_error:
                lines = body.splitlines()
                shown = 0
                for line in lines:
                    if any(marker in line for marker in BAD_MARKERS) or any(x in line for x in ("Fatal error", "Warning", "Notice", "Undefined")):
                        print(line[:240])
                        shown += 1
                        if shown >= 5:
                            break
    except Exception as exc:
        print(f"{url} FAIL {exc}")
