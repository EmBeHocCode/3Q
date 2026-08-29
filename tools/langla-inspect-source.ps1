$ErrorActionPreference = "Continue"
$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc"
$server = Join-Path $root "server\server"
$client = Join-Path $root "Client_LangLaLau"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== ROOTS ==="
foreach ($p in @($root,$server,$client)) {
  if (Test-Path $p) { Write-Host "OK $p" } else { Write-Host "MISSING $p" }
}

Write-Host "=== SERVER FILES TOP ==="
Get-ChildItem -LiteralPath $server -Force | Select-Object Mode,Length,LastWriteTime,Name | Format-Table -AutoSize

Write-Host "=== RUN FILES ==="
foreach ($f in @("config.properties","run.bat","runServerCheck.bat","dataserver.txt")) {
  $path = Join-Path $server $f
  Write-Host "--- $f ---"
  if (Test-Path $path) { Get-Content -LiteralPath $path -TotalCount 80 } else { Write-Host "MISSING" }
}

Write-Host "=== PORT HINTS IN SERVER SOURCE ==="
$patterns = @(
  "ServerSocket",
  "InetSocketAddress",
  "bind\(",
  "port",
  "14444",
  "19129",
  "19130",
  "27017",
  "3306"
)
Get-ChildItem -LiteralPath $server -Recurse -File -Include *.java,*.properties,*.txt,*.xml,*.json,*.yml,*.yaml,*.bat |
  Where-Object { $_.FullName -notmatch "\\target\\|\\out\\" } |
  Select-String -Pattern $patterns -CaseSensitive:$false |
  Select-Object -First 160 Path,LineNumber,Line |
  Format-List

Write-Host "=== CLIENT IP/PORT HINTS ==="
if (Test-Path $client) {
  Get-ChildItem -LiteralPath $client -Recurse -File -Include *.java,*.txt,*.json,*.lua,*.xml,*.properties,*.beatdz |
    Select-String -Pattern @("127.0.0.1","localhost","104.248","192.168","server","port","14444","19129","19130") -CaseSensitive:$false |
    Select-Object -First 180 Path,LineNumber,Line |
    Format-List
}

Write-Host "=== SQL DB NAMES ==="
Get-ChildItem -LiteralPath $server -File -Include *.sql |
  ForEach-Object {
    Write-Host "--- $($_.Name) ---"
    Select-String -LiteralPath $_.FullName -Pattern "CREATE DATABASE|USE |CREATE TABLE|DROP TABLE" -CaseSensitive:$false |
      Select-Object -First 30 LineNumber,Line |
      Format-Table -AutoSize
  }
