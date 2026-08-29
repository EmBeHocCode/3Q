$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== STOP OLD LANGLA JAVA ==="
$javaProcs = Get-CimInstance Win32_Process | Where-Object {
  ($_.Name -match "^javaw?\.exe$") -and ($_.CommandLine -match "LangLaZ|ServerCheck|LangLa")
}
foreach ($p in $javaProcs) {
  Write-Host "KILL PID=$($p.ProcessId) CMD=$($p.CommandLine)"
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== LOCATE MYSQL ==="
$mysqlCandidates = @(
  "C:\xampp\mysql\bin\mysql.exe",
  "C:\Users\Administrator\Downloads\xampp\mysql\bin\mysql.exe",
  "C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe",
  "C:\Program Files\MariaDB 11.4\bin\mysql.exe",
  "D:\3QVuongGia\phpStudy\MySQL\bin\mysql.exe"
)
$mysql = $mysqlCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if (-not $mysql) {
  $mysql = (Get-ChildItem -Path C:\ -Filter mysql.exe -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1).FullName
}
Write-Host "MYSQL=$mysql"
if (-not $mysql) { throw "mysql.exe not found" }

Write-Host "=== MYSQL VERSION / PORT ==="
& $mysql -uroot -e "select version(); show variables like 'datadir';"
cmd /c "netstat -ano -p tcp | findstr /R "":3306 :27017 :14444 :19129 :19130 :8080 :8088 :80"""

Write-Host "=== CREATE DATABASES ==="
& $mysql -uroot -e "CREATE DATABASE IF NOT EXISTS langla CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; CREATE DATABASE IF NOT EXISTS langladata CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

Write-Host "=== IMPORT SQL ==="
$imports = @(
  @{ Db="langla"; File="langla.sql" },
  @{ Db="langladata"; File="langladata.sql" },
  @{ Db="langladata"; File="danhhieu.sql" },
  @{ Db="langladata"; File="shoprank.sql" }
)
foreach ($i in $imports) {
  $sql = Join-Path $server $i.File
  Write-Host "IMPORT $($i.File) -> $($i.Db)"
  if (Test-Path $sql) {
    cmd /c "`"$mysql`" -uroot $($i.Db) < `"$sql`""
    Write-Host "EXIT=$LASTEXITCODE"
  } else {
    Write-Host "MISSING $sql"
  }
}

Write-Host "=== TABLE COUNTS ==="
& $mysql -uroot -e "SELECT table_schema, COUNT(*) tables FROM information_schema.tables WHERE table_schema IN ('langla','langladata') GROUP BY table_schema;"

Write-Host "=== START SERVER ==="
$runLog = Join-Path $logDir "langla-server-run.log"
$errLog = Join-Path $logDir "langla-server-err.log"
Remove-Item $runLog,$errLog -Force -ErrorAction SilentlyContinue
$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
if (-not (Test-Path $java)) { $java = "java.exe" }
$args = "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`""
$p = Start-Process -FilePath $java -ArgumentList $args -WorkingDirectory $server -RedirectStandardOutput $runLog -RedirectStandardError $errLog -PassThru -WindowStyle Hidden
Write-Host "STARTED PID=$($p.Id)"
Start-Sleep -Seconds 12

Write-Host "=== SERVER PROCESS ==="
Get-CimInstance Win32_Process | Where-Object { $_.ProcessId -eq $p.Id -or $_.CommandLine -match "LangLaZ" } |
  Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== PORTS AFTER START ==="
cmd /c "netstat -ano -p tcp | findstr /R "":3306 :27017 :14444 :19129 :19130 :8080 :8088 :80"""

Write-Host "=== STDOUT TAIL ==="
if (Test-Path $runLog) { Get-Content $runLog -Tail 120 }
Write-Host "=== STDERR TAIL ==="
if (Test-Path $errLog) { Get-Content $errLog -Tail 120 }
