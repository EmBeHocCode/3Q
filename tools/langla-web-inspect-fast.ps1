$ErrorActionPreference = "Continue"

$paths = @(
  "C:\xampp\htdocs",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
)

Write-Host "=== ROOTS ==="
foreach ($p in $paths) {
  Write-Host "--- $p"
  if (Test-Path -LiteralPath $p) {
    Get-ChildItem -LiteralPath $p -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== KEY FILE CONTENT ==="
foreach ($root in $paths) {
  foreach ($name in @("serverlist.txt","checkpc.txt","checkandroid.txt","checkios.txt","arr_data_game.bin","arr_data_game2.bin")) {
    $f = Join-Path $root $name
    Write-Host "--- $f"
    if (Test-Path -LiteralPath $f) {
      if ($name -like "*.txt") {
        Get-Content -LiteralPath $f -Raw
      } else {
        Get-Item -LiteralPath $f | Select-Object FullName,Length,LastWriteTime | Format-List
      }
    } else {
      Write-Host "MISSING"
    }
  }
}

Write-Host "=== TOP LEVEL TEXT SCAN ==="
foreach ($root in $paths) {
  Write-Host "--- $root"
  if (Test-Path -LiteralPath $root) {
    Get-ChildItem -LiteralPath $root -File -Include *.txt,*.php,*.js,*.json,*.html |
      Select-String -Pattern "localhost|127\.0\.0\.1|104\.248\.157\.207|2907|6868|serverlist|http://" |
      Select-Object Path,LineNumber,Line |
      Format-List
  }
}

Write-Host "=== LOCAL HTTP ==="
try { (Invoke-WebRequest -UseBasicParsing "http://127.0.0.1:82/serverlist.txt" -TimeoutSec 5).Content } catch { $_.Exception.Message }

Write-Host "=== PORT 82 ==="
netstat -ano | findstr ":82"
