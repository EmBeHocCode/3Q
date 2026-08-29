$ErrorActionPreference = "Continue"

Write-Host "=== PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysql|httpd|mongod" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== PORTS ==="
netstat -ano | Select-String "LISTENING|ESTABLISHED|CLOSE_WAIT" | Select-String ":2907|:80|:3306|:27017"

Write-Host "=== SERVER DIR ==="
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
if (Test-Path -LiteralPath $server) {
  Get-ChildItem -LiteralPath $server -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize
} else {
  Write-Host "MISSING $server"
}

Write-Host "=== LOG FILES ==="
$candidates = @(
  "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\langla-server-run.log",
  "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\langla-server-err.log",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\langla.log"
)
foreach ($f in $candidates) {
  Write-Host "--- $f"
  if (Test-Path -LiteralPath $f) {
    Get-Item -LiteralPath $f | Select-Object FullName,Length,LastWriteTime | Format-List
    Get-Content -LiteralPath $f -Tail 120
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== DB ACCOUNT ==="
$mysql = "C:\xampp\mysql\bin\mysql.exe"
if (Test-Path -LiteralPath $mysql) {
  cmd /c "`"$mysql`" -uroot -e `"use langla; show tables; select id, username, password, QuantityChar, activated, lock from player where username='gamepro2' limit 1;`" 2>&1"
}
