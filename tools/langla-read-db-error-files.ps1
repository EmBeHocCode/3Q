$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$files = @(
  "src\main\java\com\sg188\clan\MemberDAO.java",
  "src\main\java\SqlConnection\Connect.java",
  "src\main\java\SqlConnection\ConnectData.java",
  "src\main\java\SqlConnection\ConnectionPool.java"
)
foreach ($rel in $files) {
  $p = Join-Path $server $rel
  Write-Host "=== FILE $rel ==="
  if (Test-Path $p) {
    $lines = Get-Content -LiteralPath $p
    for ($i=1; $i -le [Math]::Min($lines.Count,260); $i++) {
      "{0,4}: {1}" -f $i,$lines[$i-1]
    }
  } else {
    Write-Host "MISSING $p"
  }
}

Write-Host "=== MYSQL TABLES DETAIL ==="
$mysql = "C:\xampp\mysql\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -e "SHOW DATABASES; SELECT table_schema, table_name FROM information_schema.tables WHERE table_schema IN ('langla','langladata') ORDER BY table_schema, table_name;"
  & $mysql -uroot langla -e "SHOW CREATE TABLE clan\G; SHOW CREATE TABLE member\G;" 2>&1
  & $mysql -uroot langladata -e "SHOW TABLES;" 2>&1
}
