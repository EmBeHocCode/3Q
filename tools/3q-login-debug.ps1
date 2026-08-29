$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

Write-Host "=== PORTS ==="
netstat -ano -p tcp |
  Select-String -Pattern ":(6001|8001|8088|9001|14001|20004)\s+.*LISTENING" |
  ForEach-Object { Write-Host $_.Line.Trim() }

Write-Host "=== UC DB SERVER LIST ==="
$mysql = "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -proot -e "select id,name,address,stride_server,cross_server from uc_hd.t_s_server_list; select id,web_host,db_host,data_host from uc_hd.t_s_server_config;" 2>&1
}

Write-Host "=== RECENT LOG FILES ==="
$dirs = @(
  "D:\3QVuongGia\data\usercenter_HD\logs",
  "D:\3QVuongGia\data\server_4001\logs",
  "D:\3QVuongGia\data\cross_android\logs",
  "C:\3q-logs"
)

$logs = foreach ($d in $dirs) {
  if (Test-Path -LiteralPath $d) {
    Get-ChildItem -LiteralPath $d -File -ErrorAction SilentlyContinue |
      Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-2) }
  }
}

$logs |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "=== LOGIN RELATED LINES ==="
$logs |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 12 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Select-String -LiteralPath $_.FullName -Pattern "login|register|account|user|meowad|123321|Exception|ERROR|WARN|refused|denied|create|server/list|getServer|auth" -ErrorAction SilentlyContinue |
      Select-Object -Last 80 |
      ForEach-Object { Write-Host $_.Line }
    Write-Host "--- tail ---"
    Get-Content -LiteralPath $_.FullName -Tail 40 -Encoding Default -ErrorAction SilentlyContinue
  }

