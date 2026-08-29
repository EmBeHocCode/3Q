$ErrorActionPreference = "Stop"

$roots = @(
  "C:\xampp\htdocs\langla",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
)

$py = @'
import os, re, sys

roots = [
    r"C:\xampp\htdocs\langla",
    r"C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)",
]
exts = {".php",".html",".htm",".css",".js",".txt",".json",".xml"}

def repair_once(s: str) -> str:
    # Classic UTF-8 read as cp1252/latin1 mojibake: LÃ ng LÃ¡, Ä‘ăng, thÃ´ng...
    try:
        fixed = s.encode("latin1").decode("utf-8")
        return fixed
    except Exception:
        return s

def score_bad(s: str) -> int:
    return sum(s.count(x) for x in ["Ã", "Â", "Ä", "Æ", "áº", "á»", "�"])

patched = []
for root in roots:
    if not os.path.isdir(root):
        continue
    for dirpath, dirnames, filenames in os.walk(root):
        for name in filenames:
            ext = os.path.splitext(name)[1].lower()
            if ext not in exts:
                continue
            path = os.path.join(dirpath, name)
            try:
                data = open(path, "rb").read()
            except Exception:
                continue
            # Skip binary-looking text files
            if b"\x00" in data:
                continue
            for enc in ("utf-8-sig", "utf-8", "cp1252", "latin1"):
                try:
                    text = data.decode(enc)
                    break
                except Exception:
                    text = None
            if text is None:
                continue
            before = score_bad(text)
            fixed = text
            # Apply while it improves. Usually one pass is enough.
            for _ in range(3):
                cand = repair_once(fixed)
                if score_bad(cand) < score_bad(fixed):
                    fixed = cand
                else:
                    break
            # Known residue from broken replacement in console/source
            replacements = {
                "Làng Lá Plus": "Làng Lá Plus",
                "THÔNG BÁO": "THÔNG BÁO",
            }
            for a,b in replacements.items():
                fixed = fixed.replace(a,b)
            after = score_bad(fixed)
            if fixed != text and after < before:
                open(path, "wb").write(fixed.encode("utf-8"))
                patched.append((path, before, after))

for path, before, after in patched:
    print(f"PATCHED bad={before}->{after} {path}")
print(f"TOTAL_PATCHED={len(patched)}")
'@

$tmp = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\fix_encoding.py"
Set-Content -LiteralPath $tmp -Value $py -Encoding UTF8
python $tmp

Write-Host "=== SMOKE ERROR TEXT ==="
foreach ($url in @(
  "http://127.0.0.1/langla/",
  "http://127.0.0.1/langla/login/",
  "http://127.0.0.1/langla/register/",
  "http://127.0.0.1/langla/bang-xep-hang/",
  "http://127.0.0.1/langla/tai-ve/"
)) {
  Write-Host "--- $url"
  $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 8
  Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength)"
  if ($r.Content -match "Ã|Â|Ä|Æ|áº|á»|Fatal error|Warning|Notice") {
    Write-Host "STILL_BAD_TEXT"
    ($r.Content -split "`n" | Select-String -Pattern "Ã|Â|Ä|Æ|áº|á»|Fatal error|Warning|Notice" | Select-Object -First 5) | ForEach-Object { $_.Line }
  } else {
    Write-Host "NO_BAD_TEXT"
  }
}
