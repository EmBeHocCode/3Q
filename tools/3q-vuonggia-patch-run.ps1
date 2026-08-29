$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"
$ip = "104.248.157.207"
$ts = Get-Date -Format "yyyyMMdd-HHmmss"

Write-Host "=== PATCH datasource.xml PasswordDesDataSource -> BoneCPDataSource ==="
foreach ($file in @("$root\data\cross_android\config\datasource.xml", "$root\data\server_4001\config\datasource.xml")) {
  if (Test-Path $file) {
    Copy-Item $file "$file.bak.$ts" -Force
    (Get-Content $file) -replace 'com\.playmore\.datasource\.PasswordDesDataSource', 'com.jolbox.bonecp.BoneCPDataSource' | Set-Content -Encoding UTF8 $file
    Write-Host "patched $file"
  }
}

Write-Host "=== FIX uc_hd server config/list ==="
$sql = @"
use uc_hd;
update t_s_server_config
set web_host='http://127.0.0.1:23701',
    db_host='jdbc:mysql://127.0.0.1:3306/server_4001',
    db_user='root',
    db_password='root',
    data_host='jdbc:mysql://127.0.0.1:3306/server_android_data_3k'
where id=4001;
delete from t_s_server_config where id<>4001;
update t_s_server_list
set name='S1',
    address='104.248.157.207:8001',
    stride_server='127.0.0.1:14001',
    cross_server='127.0.0.1:14001',
    mark=0,
    system=0
where id=4001;
delete from t_s_server_list where id<>4001;
select * from t_s_server_config;
select id,name,mark,address,stride_server,cross_server from t_s_server_list;
"@
$sqlPath = "C:\Users\Administrator\Desktop\fix-ucdb-2.sql"
Set-Content -Encoding UTF8 $sqlPath $sql
cmd /c "`"$mysql`" -uroot -proot < `"$sqlPath`""

Write-Host "=== STOP old Java except maybe none ==="
Get-CimInstance Win32_Process | Where-Object { $_.Name -eq "java.exe" } | ForEach-Object {
  Write-Host "kill java pid=$($_.ProcessId)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 3

function Start-Capture($name, $workdir, $bat, $waitSec) {
  $log = "C:\Users\Administrator\Desktop\$name-run.log"
  $runner = "C:\Users\Administrator\Desktop\$name-runner.cmd"
  Set-Content -Encoding ASCII $runner "@echo off`r`ncd /d `"$workdir`"`r`ncall `"$bat`" > `"$log`" 2>&1`r`n"
  Write-Host "START $name"
  Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$runner`"" -WorkingDirectory $workdir -WindowStyle Minimized
  Start-Sleep -Seconds $waitSec
  Write-Host "TAIL $name"
  if (Test-Path $log) { Get-Content $log -Tail 60 }
}

Start-Capture "uc" "$root\data\usercenter_HD" "$root\data\usercenter_HD\start.bat" 20
Start-Capture "cross" "$root\data\cross_android" "$root\data\cross_android\start.bat" 45
Start-Capture "s1" "$root\data\server_4001" "$root\data\server_4001\start.bat" 60

Write-Host "=== VERIFY PROCESS/PORT ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize
Get-NetTCPConnection -State Listen |
  Where-Object { @(80,81,8080,8088,9001,6001,8001,8806,14001,20004,23701,23702,23703,23799) -contains $_.LocalPort } |
  Sort-Object LocalPort |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize
