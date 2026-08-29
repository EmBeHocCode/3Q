$ErrorActionPreference = "Continue"

Write-Host "=== WHO ==="
whoami
hostname

Write-Host "=== SUBST BEFORE/AFTER ==="
cmd /c subst
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
cmd /c subst

Write-Host "=== PATHS ==="
foreach ($p in @(
  "D:\3QVuongGia",
  "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe",
  "D:\3QVuongGia\data\usercenter_HD\start.bat",
  "D:\3QVuongGia\data\cross_android\start.bat",
  "D:\3QVuongGia\data\server_4001\start.bat",
  "C:\xampp\mysql\bin\mysqld.exe",
  "C:\xampp\apache\bin\httpd.exe"
)) {
  Write-Host ("{0} => {1}" -f $p, (Test-Path $p))
}

Write-Host "=== LISTEN 3306/80/9001/14001/20004/8080/81 ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { @(80,81,3306,8080,9001,14001,20004) -contains $_.LocalPort } |
  Sort-Object LocalPort |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize

Write-Host "=== PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy|xampp" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-List

Write-Host "=== MYSQL TESTS ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  Write-Host "--- proot ---"
  & $mysql -uroot -proot -e "select current_user(); show variables like 'port'; show variables like 'datadir';"
  Write-Host "--- root/no-pass ---"
  & $mysql -uroot -e "select current_user();" 2>&1
}
