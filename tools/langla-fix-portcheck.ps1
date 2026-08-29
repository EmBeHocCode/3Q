$ErrorActionPreference = "Stop"

$content = "id=Lang La`r`nLangLa VPS=100:104.248.157.207:2907:2906|0|131|0|"
$files = @(
  "C:\xampp\htdocs\serverlist.txt",
  "C:\xampp\htdocs\langla\serverlist.txt",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\serverlist.txt"
)

foreach ($f in $files) {
  if (Test-Path -LiteralPath (Split-Path -Parent $f)) {
    Set-Content -LiteralPath $f -Value $content -Encoding ASCII
    Write-Host "UPDATED $f"
    Get-Content -LiteralPath $f -Raw
  }
}

Write-Host "HTTP:"
(Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/serverlist.txt" -TimeoutSec 5).Content
