$ErrorActionPreference = "Continue"

$src = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
$dst = "C:\xampp\htdocs\langla"

if (!(Test-Path -LiteralPath $src)) {
  throw "Missing source: $src"
}
New-Item -ItemType Directory -Force -Path $dst | Out-Null

Write-Host "=== ROBOCOPY FULL WEB ==="
robocopy $src $dst /E /R:1 /W:1 /NFL /NDL /NP
$code = $LASTEXITCODE
Write-Host "ROBOCOPY_EXIT=$code"
if ($code -ge 8) {
  throw "Robocopy failed with exit code $code"
}

Set-Content -LiteralPath (Join-Path $dst "serverlist.txt") -Value "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2906|0|131|0|" -Encoding ASCII

Write-Host "=== REQUIRED PATHS ==="
foreach ($p in @(
  "in\head.php",
  "in\foot_tb.php",
  "css",
  "images",
  "img",
  "login",
  "register",
  "serverlist.txt",
  "checkpc.txt"
)) {
  $full = Join-Path $dst $p
  Write-Host "$p EXISTS=$((Test-Path -LiteralPath $full))"
}

Write-Host "=== HTTP HOME SAMPLE ==="
$r = Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/" -TimeoutSec 8
Write-Host "status=$($r.StatusCode) len=$($r.RawContentLength)"
($r.Content -split "`n" | Select-Object -First 20) -join "`n"
