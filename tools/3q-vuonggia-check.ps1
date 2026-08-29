$ErrorActionPreference = "Continue"

Write-Host "=== USER/HOST ==="
whoami
hostname

Write-Host "=== SUBST ==="
cmd /c subst

Write-Host "=== PATH CHECK ==="
$paths = @(
  "C:\Users\Administrator\Downloads\3QVuongGia\3QVuongGia",
  "D:\3QVuongGia",
  "D:\3QVuongGia\phpStudy\MySQL\my.ini",
  "D:\3QVuongGia\www\login\uc_hd.sql",
  "D:\3QVuongGia\data\usercenter_HD\start.bat",
  "D:\3QVuongGia\data\cross_android\start.bat",
  "D:\3QVuongGia\data\server_4001\start.bat"
)
foreach ($p in $paths) {
  Write-Host ("{0} => {1}" -f $p, (Test-Path $p))
}

Write-Host "=== MYSQL DATADIR ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -e "show variables like 'datadir'; show databases;"
} else {
  Write-Host "mysql.exe missing: $mysql"
}

Write-Host "=== PROCESSES ==="
Get-Process mysqld,java,httpd,phpStudy -ErrorAction SilentlyContinue |
  Select-Object ProcessName,Id,CPU,WorkingSet,Path |
  Format-Table -AutoSize
