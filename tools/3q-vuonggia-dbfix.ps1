$ErrorActionPreference = "Stop"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"

$root = "D:\3QVuongGia"
$mysql = "$root\phpStudy\MySQL\bin\mysql.exe"
$sql = "$root\www\login\uc_hd.sql"

Write-Host "=== PATH ==="
Write-Host "root exists:" (Test-Path $root)
Write-Host "mysql exists:" (Test-Path $mysql)
Write-Host "sql exists:" (Test-Path $sql)

if (!(Test-Path $mysql)) { throw "Missing mysql.exe: $mysql" }
if (!(Test-Path $sql)) { throw "Missing SQL: $sql" }

Write-Host "=== MYSQL DATADIR BEFORE ==="
& $mysql -uroot -proot -e "show variables like 'datadir';"

Write-Host "=== IMPORT uc_hd.sql ==="
cmd /c "`"$mysql`" -uroot -proot uc_hd < `"$sql`""
if ($LASTEXITCODE -ne 0) { throw "Import failed with exit code $LASTEXITCODE" }

Write-Host "=== VERIFY TABLES ==="
& $mysql -uroot -proot -e "use uc_hd; show tables like 't_s_server_config'; show tables like 't_s_server_list'; select count(*) as server_config_count from t_s_server_config; select count(*) as server_list_count from t_s_server_list;"

Write-Host "OK_DB_IMPORT_DONE"
