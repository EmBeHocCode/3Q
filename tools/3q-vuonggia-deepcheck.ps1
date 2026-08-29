$ErrorActionPreference = "Continue"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"

Write-Host "=== MYSQL USERS ==="
& $mysql -uroot -proot -e "select user,host,password from mysql.user; show databases;"

Write-Host "=== CONFIG CLASS CHECK ==="
foreach ($file in @("$root\data\cross_android\config\datasource.xml", "$root\data\server_4001\config\datasource.xml")) {
  Write-Host "--- $file ---"
  Select-String -Path $file -Pattern "dataSource|class=|jdbcUrl|username|password" | ForEach-Object { $_.Line }
}

Write-Host "=== UC DB CONFIG ==="
& $mysql -uroot -proot -e "use uc_hd; select * from t_s_server_config; select id,name,mark,address,stride_server,cross_server from t_s_server_list;"

Write-Host "=== LOG FILE TIMES ==="
Get-ChildItem "C:\Users\Administrator\Desktop\*-run.log","D:\3QVuongGia\data\cross_android\logs\*","D:\3QVuongGia\data\server_4001\logs\*" -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "=== CURRENT JAVA ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize
