$ErrorActionPreference = "Continue"
$mysql = "C:\xampp\mysql\bin\mysql.exe"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== PORT / CONNECTIONS 2907 ==="
cmd /c "netstat -ano -p tcp | findstr :2907"

Write-Host "=== FIND USER TABLES/COLUMNS ==="
& $mysql -uroot -e "SELECT table_schema, table_name, column_name FROM information_schema.columns WHERE table_schema IN ('langla','langladata') AND (column_name LIKE '%user%' OR column_name LIKE '%account%' OR column_name LIKE '%pass%' OR column_name LIKE '%name%' OR table_name LIKE '%user%' OR table_name LIKE '%account%' OR table_name LIKE '%player%') ORDER BY table_schema, table_name, ordinal_position;"

Write-Host "=== TABLE COUNTS ==="
& $mysql -uroot -e "SELECT table_schema, table_name, table_rows FROM information_schema.tables WHERE table_schema IN ('langla','langladata') ORDER BY table_schema, table_name;"

Write-Host "=== SEARCH gamepro2 ==="
foreach ($db in @("langla","langladata")) {
  Write-Host "--- DB $db ---"
  $tables = & $mysql -uroot -N -B -e "SELECT table_name FROM information_schema.tables WHERE table_schema='$db';"
  foreach ($t in $tables) {
    $cols = & $mysql -uroot -N -B -e "SELECT column_name FROM information_schema.columns WHERE table_schema='$db' AND table_name='$t' AND data_type IN ('varchar','char','text','mediumtext','longtext');"
    foreach ($c in $cols) {
      $q = "SELECT '$db.$t.$c' loc, COUNT(*) cnt FROM `$db`.`$t` WHERE `$c` LIKE '%gamepro2%';"
      & $mysql -uroot -N -B -e $q 2>$null | Where-Object { $_ -notmatch "`t0$" }
    }
  }
}

Write-Host "=== LOG TAIL ==="
foreach ($f in @(
  "$logDir\langla-server-run.log",
  "$logDir\langla-server-err.log",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\langla.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Tail 160 } else { Write-Host "MISSING" }
}
