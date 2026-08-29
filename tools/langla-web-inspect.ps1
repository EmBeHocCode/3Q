$ErrorActionPreference = "Continue"

$paths = @(
  "C:\xampp\htdocs",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
)

Write-Host "=== WEB ROOT CHECK ==="
foreach ($p in $paths) {
  Write-Host "--- PATH: $p"
  if (Test-Path -LiteralPath $p) {
    Get-ChildItem -LiteralPath $p -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== KEY FILES ==="
$files = @(
  "C:\xampp\htdocs\serverlist.txt",
  "C:\xampp\htdocs\checkpc.txt",
  "C:\xampp\htdocs\checkandroid.txt",
  "C:\xampp\htdocs\checkios.txt",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\serverlist.txt",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\checkpc.txt",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\checkandroid.txt",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\checkios.txt"
)

foreach ($f in $files) {
  Write-Host "--- FILE: $f"
  if (Test-Path -LiteralPath $f) {
    Get-Content -LiteralPath $f -Raw
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== IP/DOMAIN SCAN IN WEB FILES ==="
foreach ($p in $paths) {
  if (Test-Path -LiteralPath $p) {
    Write-Host "--- SCAN: $p"
    Get-ChildItem -LiteralPath $p -Recurse -File -Include *.txt,*.php,*.js,*.json,*.html,*.xml,*.ini,*.config |
      Select-String -Pattern "localhost|127\.0\.0\.1|104\.248\.157\.207|2907|6868|serverlist|langla|beatdz|http://" |
      Select-Object Path,LineNumber,Line |
      Format-List
  }
}

Write-Host "=== APACHE LISTEN ==="
netstat -ano | findstr ":82"
