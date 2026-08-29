$ErrorActionPreference = "Continue"
$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc"
$srv = Join-Path $root "server\server"

Write-Host "=== CORE FILES ==="
foreach ($f in @(
  "$srv\config.properties",
  "$srv\run.bat",
  "$srv\runServerCheck.bat",
  "$srv\dataserver.txt",
  "$srv\langla.sql",
  "$srv\langladata.sql",
  "$srv\danhhieu.sql",
  "$srv\shoprank.sql"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    if ((Get-Item $f).Length -gt 20000) {
      Get-Content -LiteralPath $f -TotalCount 80
    } else {
      Get-Content -LiteralPath $f -Raw
    }
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== SQL CREATE/USE ==="
foreach ($f in Get-ChildItem -LiteralPath $srv -File -Filter "*.sql" -ErrorAction SilentlyContinue) {
  Write-Host "--- $($f.Name) ---"
  Select-String -LiteralPath $f.FullName -Pattern "CREATE DATABASE|USE |CREATE TABLE|INSERT INTO" -SimpleMatch:$false |
    Select-Object -First 40 |
    ForEach-Object { "$($_.LineNumber):$($_.Line)" }
}

Write-Host "=== SERVER SOURCE PORT HINTS ==="
Get-ChildItem -LiteralPath "$srv\src" -Recurse -File -Include "*.java" -ErrorAction SilentlyContinue |
  Select-String -Pattern "port|server|mongodb|mysql|config|socket|listen|bind|host|db" -SimpleMatch:$false |
  Select-Object -First 160 |
  ForEach-Object { "$($_.Path):$($_.LineNumber):$($_.Line)" }

Write-Host "=== EXISTING MYSQL/MONGO INSTALLS ==="
Get-ChildItem -Path "C:\Program Files","C:\Program Files (x86)","C:\ProgramData","C:\tools","C:\" -Recurse -ErrorAction SilentlyContinue -Include "mysql.exe","mysqld.exe","mongod.exe","mongosh.exe","mongo.exe" |
  Select-Object -First 80 FullName,Length,LastWriteTime |
  Format-Table -AutoSize
