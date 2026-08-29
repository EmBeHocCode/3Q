$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

$root = "D:\3QVuongGia"
$ts = Get-Date -Format "yyyyMMdd-HHmmss"
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"

Write-Host "=== BEFORE PORTS ==="
netstat -ano -p tcp |
  Select-String -Pattern ":(6001|8001|9001|14001|20004)\s+.*LISTENING" |
  ForEach-Object { Write-Host $_.Line.Trim() }

Write-Host "=== PATCH S1 CONFIG TO CLIENT PORT 8001 ==="
$cfg = "$root\data\server_4001\config\global.config"
if (Test-Path -LiteralPath $cfg) {
  Copy-Item -LiteralPath $cfg -Destination "$cfg.bak-port-$ts" -Force
  $text = Get-Content -LiteralPath $cfg -Raw -Encoding Default
  $text = $text -replace "net\.server\.port\s*=\s*\d+", "net.server.port=8001"
  $text = $text -replace "net\.server\.host\s*=\s*.*", "net.server.host=0.0.0.0"
  $text = $text -replace "cross\.server\.address\s*=\s*.*", "cross.server.address=127.0.0.1:20004"
  Set-Content -LiteralPath $cfg -Value $text -Encoding Default
  Get-Content -LiteralPath $cfg -Encoding Default | Select-String -Pattern "net.server.port|net.server.host|net.cross.server.port|cross.server.address"
}

Write-Host "=== PATCH UC DB SERVER LIST ==="
if (Test-Path -LiteralPath $mysql) {
  & $mysql -uroot -proot -e "update uc_hd.t_s_server_list set address='104.248.157.207:8001', stride_server='127.0.0.1:14001', cross_server='127.0.0.1:14001' where id=4001; select id,name,address,stride_server,cross_server from uc_hd.t_s_server_list;" 2>&1
}

Write-Host "=== RESTART 3Q TASK ==="
Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -and $_.CommandLine -like "*D:\3QVuongGia*" -and $_.Name -match "java|cmd" } |
  ForEach-Object {
    Write-Host "kill $($_.Name) pid=$($_.ProcessId)"
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }
Start-Sleep -Seconds 3
Start-ScheduledTask -TaskName "3QVuongGiaServer"

Write-Host "STARTED_TASK_WAITING"
