$ErrorActionPreference = "Stop"

$htdocs = "C:\xampp\htdocs"
$langla = Join-Path $htdocs "langla"
$backup = Join-Path $htdocs "_root_langla_backup_20260813"

if (!(Test-Path -LiteralPath $htdocs)) {
  throw "Missing htdocs: $htdocs"
}
if (!(Test-Path -LiteralPath $langla)) {
  throw "Missing langla folder: $langla"
}

New-Item -ItemType Directory -Force -Path $backup | Out-Null

$moveNames = @(
  "assets",
  "bang-xep-hang",
  "community",
  "css",
  "encode",
  "images",
  "img",
  "in",
  "lib",
  "lich-su",
  "login",
  "nap-tien",
  "register",
  "tai-ve",
  "404.html",
  "arr_data_game.bin",
  "arr_data_game2.bin",
  "call_back.php",
  "checkandroid.txt",
  "checkios.txt",
  "checkpc.txt",
  "core.jar",
  "exit.php",
  "gdx.jar",
  "index.php",
  "jasr.dll",
  "md5.php",
  "serverlist.txt"
)

Write-Host "=== MOVE ROOT LANGLA CLUTTER TO BACKUP ==="
foreach ($name in $moveNames) {
  $from = Join-Path $htdocs $name
  $to = Join-Path $backup $name
  if (Test-Path -LiteralPath $from) {
    Move-Item -LiteralPath $from -Destination $to -Force
    Write-Host "MOVED $name"
  }
}

Write-Host "=== KEEPING XAMPP DEFAULTS ==="
foreach ($name in @("dashboard","webalizer","xampp","applications.html","bitnami.css","favicon.ico","index-xampp-backup.php","langla")) {
  $p = Join-Path $htdocs $name
  if (Test-Path -LiteralPath $p) {
    Write-Host "KEEP $name"
  }
}

Write-Host "=== HTTP TEST /langla ==="
(Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/serverlist.txt" -TimeoutSec 5).Content
(Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/checkpc.txt" -TimeoutSec 5).StatusCode

Write-Host "=== HTDOCS NOW ==="
Get-ChildItem -LiteralPath $htdocs -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize
