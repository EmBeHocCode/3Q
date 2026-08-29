$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== TCP 14001/6001/9001 ==="
Get-NetTCPConnection -LocalPort 14001,6001,9001 -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess |
  Sort-Object LocalPort,State |
  Format-Table -AutoSize

Write-Host "=== PROCESS OWNING 14001 ==="
$pid14001 = (Get-NetTCPConnection -LocalPort 14001 -State Listen -ErrorAction SilentlyContinue | Select-Object -First 1).OwningProcess
if ($pid14001) {
  Get-CimInstance Win32_Process -Filter "ProcessId=$pid14001" |
    Select-Object ProcessId,Name,CommandLine |
    Format-List
}

Write-Host "=== SERVER CONFIG HITS ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\config\global.config",
  "D:\3QVuongGia\data\server_4001\config\global.config.gs",
  "D:\3QVuongGia\data\server_4001\config\server.properties",
  "D:\3QVuongGia\data\server_4001\config\config.properties"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -Path $f -Pattern "server|host|port|address|cross|http|center|gm|zone" -ErrorAction SilentlyContinue |
      Select-Object -First 80 |
      ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== MYSQL SERVER LISTS ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -e "select id,name,address,stride_server,cross_server,server_id from uc_hd.t_s_server_list; select * from uc_hd.t_s_server_list\G" 2>&1
}

Write-Host "=== RECENT LOG FILES ==="
Get-ChildItem "D:\3QVuongGia\data\server_4001" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -in ".log",".txt",".out",".err" -or $_.Name -match "log|error|work" } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 15 FullName,LastWriteTime,Length |
  Format-Table -AutoSize

Write-Host "=== LOG TAILS ==="
$files = Get-ChildItem "D:\3QVuongGia\data\server_4001" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -in ".log",".txt",".out",".err" -or $_.Name -match "log|error|work" } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 4
foreach ($f in $files) {
  Write-Host "--- $($f.FullName) ---"
  Get-Content $f.FullName -Tail 80 -ErrorAction SilentlyContinue
}
