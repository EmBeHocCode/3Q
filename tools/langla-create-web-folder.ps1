$ErrorActionPreference = "Stop"

$src = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
$dst = "C:\xampp\htdocs\langla"

Write-Host "SRC_EXISTS=$((Test-Path -LiteralPath $src)) $src"
Write-Host "DST_BEFORE=$((Test-Path -LiteralPath $dst)) $dst"

if (!(Test-Path -LiteralPath $src)) {
  throw "Missing source web folder: $src"
}

New-Item -ItemType Directory -Force -Path $dst | Out-Null
Copy-Item -LiteralPath (Join-Path $src "*") -Destination $dst -Recurse -Force

$content = "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2907|0|131|0|"
Set-Content -LiteralPath (Join-Path $dst "serverlist.txt") -Value $content -Encoding ASCII

Write-Host "DST_AFTER:"
Get-ChildItem -LiteralPath $dst -Force | Select-Object -First 40 Name,Mode,Length,LastWriteTime | Format-Table -AutoSize

Write-Host "SERVERLIST_FILE:"
Get-Content -LiteralPath (Join-Path $dst "serverlist.txt") -Raw

Write-Host "HTTP_TEST:"
(Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/serverlist.txt" -TimeoutSec 5).Content
