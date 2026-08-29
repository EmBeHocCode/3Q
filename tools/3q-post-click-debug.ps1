$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== TCP CLIENT PATH ==="
Get-NetTCPConnection -LocalPort 6001,8001,14001,9001 -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess |
  Sort-Object LocalPort,RemoteAddress,RemotePort |
  Format-Table -AutoSize

Write-Host "=== PORTPROXY ==="
netsh interface portproxy show all

Write-Host "=== SERVER LIST DB ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -e "select id,name,address,stride_server,cross_server,min_version,max_version from uc_hd.t_s_server_list; select * from uc_hd.users where username='meowad'\G" 2>&1
  & $mysql -uroot -proot -N -e "select table_schema,table_name,column_name from information_schema.columns where table_schema in ('server_4001','uc_hd') and (column_name like '%account%' or column_name like '%user%' or column_name like '%player%' or column_name like '%token%') order by table_schema,table_name,ordinal_position limit 120;" 2>&1
}

Write-Host "=== RECENT LOG MATCHES ==="
$patterns = "login|account|user|player|token|session|connect|disconnect|exception|error|refuse|fail|verify|meowad|4001"
$files = @()
$files += Get-ChildItem "D:\3QVuongGia\data\server_4001\logs" -Recurse -File -ErrorAction SilentlyContinue
$files += Get-ChildItem "D:\3QVuongGia\data\usercenter_HD\logs" -Recurse -File -ErrorAction SilentlyContinue
$files += Get-ChildItem "C:\3q-logs" -File -ErrorAction SilentlyContinue
$files |
  Where-Object { $_.LastWriteTime -gt (Get-Date).AddMinutes(-20) -and $_.Length -lt 20000000 } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) $($_.LastWriteTime) $($_.Length) ---"
    Select-String -LiteralPath $_.FullName -Pattern $patterns -SimpleMatch:$false -ErrorAction SilentlyContinue |
      Select-Object -Last 80 |
      ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  }

Write-Host "=== LATEST TAILS ==="
foreach ($f in @(
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log",
  "D:\3QVuongGia\data\server_4001\logs\collection\login.log",
  "D:\3QVuongGia\data\server_4001\logs\collection\online.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Tail 80 }
}
