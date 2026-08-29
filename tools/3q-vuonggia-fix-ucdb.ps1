$ErrorActionPreference = "Stop"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"
$ip = "104.248.157.207"

$sql = @"
use uc_hd;
update t_s_server_config
set
  web_host='http://127.0.0.1:23701',
  db_host='jdbc:mysql://127.0.0.1:3306/server_4001',
  db_user='root',
  db_password='root',
  data_host='jdbc:mysql://127.0.0.1:3306/server_android_data_3k'
where id=4001;
delete from t_s_server_config where id<>4001;
update t_s_server_list
set
  name='S1',
  address='$ip:8001',
  stride_server='127.0.0.1:14001',
  cross_server='127.0.0.1:14001',
  mark=0,
  system=0
where id=4001;
delete from t_s_server_list where id<>4001;
select * from t_s_server_config;
select id,name,mark,address,stride_server,cross_server from t_s_server_list;
"@

$tmp = "C:\Users\Administrator\Desktop\fix-ucdb.sql"
Set-Content -Encoding UTF8 $tmp $sql
cmd /c "`"$mysql`" -uroot -proot < `"$tmp`""
if ($LASTEXITCODE -ne 0) { throw "mysql update failed $LASTEXITCODE" }
Write-Host "OK_UCDB_FIXED"
