$ErrorActionPreference = "Continue"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== D ROOT ==="
cmd /c subst
if (Test-Path "D:\3QVuongGia") {
  Get-ChildItem -LiteralPath "D:\3QVuongGia" -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize
} else {
  Write-Host "MISSING D:\3QVuongGia"
}

Write-Host "=== LISTEN PORTS ==="
netstat -ano -p tcp | Select-String ":80 |:3306 |:6001 |:8001 |:8080 |:9001 |:14001 |:20004 " | ForEach-Object { $_.Line }

Write-Host "=== JAVA PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  Select-Object ProcessId,CommandLine |
  Format-List

Write-Host "=== START BATS ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\start.bat",
  "D:\3QVuongGia\data\cross_android\start.bat",
  "D:\3QVuongGia\data\usercenter_HD\start.bat",
  "D:\3QVuongGia\1 - GM.bat"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Raw } else { Write-Host "MISSING" }
}

Write-Host "=== CONFIG FILES ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\config\global.config",
  "D:\3QVuongGia\data\server_4001\config\global.config.gs",
  "D:\3QVuongGia\data\cross_android\config\global.config",
  "D:\3QVuongGia\data\usercenter_HD\config\global.config"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Raw } else { Write-Host "MISSING" }
}

Write-Host "=== FULL SERVERINFO LINES ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -LiteralPath $f -Pattern "ServerInfoProvider|http start|Destroying|Connection pool|error|Exception|Caused by" -Context 3,3 |
      ForEach-Object {
        $_.Context.PreContext
        $_.Line
        $_.Context.PostContext
        "-----"
      }
  } else {
    Write-Host "MISSING"
  }
}

Write-Host "=== MYSQL TABLES SERVER-ish ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -N -e "show databases;" 2>&1
  & $mysql -uroot -proot -N -e "select table_schema,table_name from information_schema.tables where table_name like '%server%' or table_name like '%zone%' or table_name like '%notice%' order by table_schema,table_name limit 80;" 2>&1
}
