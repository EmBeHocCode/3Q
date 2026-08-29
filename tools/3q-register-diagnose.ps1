$ErrorActionPreference = "Continue"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== D ROOT ==="
cmd /c dir D:\3QVuongGia 2>&1

Write-Host "=== PORTS ==="
foreach ($p in 80,8080,9001,14001,8001,20004,3306) {
  $rows = netstat -ano -p tcp | Select-String (":$p\s")
  if ($rows) {
    Write-Host "OK $p"
    $rows | ForEach-Object { $_.Line }
  } else {
    Write-Host "MISS $p"
  }
}

Write-Host "=== JAVA / MYSQL PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|nginx|phpStudy" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== S1 CONFIG FILES ==="
$cfgs = @(
  "D:\3QVuongGia\data\server_4001\config\global.config",
  "D:\3QVuongGia\data\server_4001\config\global.config.gs"
)
foreach ($f in $cfgs) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -Path $f -Pattern "net\.server|cross|server\.port|server\.host|address" -SimpleMatch:$false
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== MYSQL SERVER LIST ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -e "select id,name,address,stride_server,cross_server from uc_hd.t_s_server_list;" 2>&1
} else {
  Write-Host "MISSING mysql.exe"
}

Write-Host "=== RECENT UC LOGS ==="
Get-ChildItem "D:\3QVuongGia\data\usercenter_HD" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -in ".log",".txt",".out" -or $_.Name -match "log|error" } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 8 FullName,LastWriteTime,Length |
  Format-Table -AutoSize

Write-Host "=== RECENT S1 LOG TAILS ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content $f -Tail 80 } else { Write-Host "MISSING" }
}
