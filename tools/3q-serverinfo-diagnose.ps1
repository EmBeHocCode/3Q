$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== UC ENDPOINTS ==="
foreach ($url in @(
  "http://127.0.0.1:9001/server/get.do",
  "http://127.0.0.1:9001/server/get.do?serverId=4001",
  "http://127.0.0.1:9001/server/get.do?serverId=5001",
  "http://127.0.0.1:9001/server/get.do?id=4001",
  "http://127.0.0.1:9001/server/get.do?id=5001"
)) {
  Write-Host "--- $url ---"
  try {
    $r = Invoke-WebRequest -UseBasicParsing -Uri $url -TimeoutSec 8
    Write-Host ("STATUS " + [int]$r.StatusCode)
    Write-Host $r.Content
  } catch {
    Write-Host ("ERR " + $_.Exception.Message)
    if ($_.Exception.Response) {
      try {
        $reader = New-Object IO.StreamReader($_.Exception.Response.GetResponseStream())
        Write-Host $reader.ReadToEnd()
      } catch {}
    }
  }
}

Write-Host "=== MYSQL SERVER TABLE CANDIDATES ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (!(Test-Path $mysql)) {
  Write-Host "MISSING mysql.exe"
  exit 0
}

& $mysql -uroot -proot -N -e "select table_schema,table_name from information_schema.tables where table_schema in ('uc_hd','server_4001','server_android_data','server_android_data_3k') and (table_name like '%server%' or table_name like '%zone%' or table_name like '%game%') order by table_schema,table_name;" 2>&1

Write-Host "=== UC_HD TABLE SCHEMAS ==="
& $mysql -uroot -proot -N -e "select table_name,column_name,column_type from information_schema.columns where table_schema='uc_hd' and (table_name like '%server%' or table_name like '%zone%' or table_name like '%game%') order by table_name,ordinal_position;" 2>&1

Write-Host "=== UC_HD SERVER ROWS ==="
& $mysql -uroot -proot -e "select * from uc_hd.t_s_server_list\G" 2>&1
& $mysql -uroot -proot -e "select * from uc_hd.t_s_server\G" 2>&1
& $mysql -uroot -proot -e "select * from uc_hd.server_list\G" 2>&1

Write-Host "=== CONFIG IDENTITY ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\config\global.config",
  "D:\3QVuongGia\data\server_4001\config\global.config.gs"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -LiteralPath $f -Pattern "server.identity|server.mergeServerIds|net.server.port|net.cross.server.port|cross.server.address|server_android_data" |
      ForEach-Object { $_.Line }
  }
}
