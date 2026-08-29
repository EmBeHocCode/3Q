$ErrorActionPreference = "Continue"

$mysql = "C:\xampp\mysql\bin\mysql.exe"
if (!(Test-Path -LiteralPath $mysql)) {
  throw "Missing mysql"
}

Write-Host "=== TABLES SHOP-LIKE ==="
cmd /c "`"$mysql`" -uroot -e `"use langla; show tables like '%shop%'; show tables like '%item%';`" 2>&1"

Write-Host "=== SHOP TABLE DESCRIBE/SAMPLES ==="
$tablesRaw = cmd /c "`"$mysql`" -uroot -N -e `"use langla; show tables;`" 2>&1
$tables = $tablesRaw -split "`r?`n" | Where-Object { $_ -match "shop|item" }
foreach ($t in $tables) {
  Write-Host "--- TABLE $t"
  cmd /c "`"$mysql`" -uroot -e `"use langla; describe $t; select * from $t limit 10;`" 2>&1"
}
