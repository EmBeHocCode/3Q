$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
$mysql = "C:\xampp\mysql\bin\mysql.exe"
$mongo = "C:\Program Files\MongoDB\Server\8.3\bin\mongod.exe"
$mongoData = "C:\tools\mongodb-data"
$mongoLog = "C:\tools\mongodb-log\mongod-direct.log"
New-Item -ItemType Directory -Force -Path $logDir,$mongoData,(Split-Path $mongoLog) | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== STOP OLD LANGLA JAVA ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | ForEach-Object {
  Write-Host "KILL PID=$($_.ProcessId)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== ENSURE MONGO RUNNING ==="
if (-not (Get-Process mongod -ErrorAction SilentlyContinue)) {
  Start-Process -FilePath $mongo -ArgumentList "--dbpath `"$mongoData`" --bind_ip 127.0.0.1 --port 27017 --logpath `"$mongoLog`" --logappend" -WindowStyle Hidden
  Start-Sleep -Seconds 5
}

Write-Host "=== MYSQL RUNTIME FIX ==="
& $mysql -uroot -e "SET GLOBAL max_connections=1000; SET GLOBAL wait_timeout=28800; SET GLOBAL interactive_timeout=28800;"
& $mysql -uroot langla -e "UPDATE clan SET updated_at=CURDATE(); UPDATE clan_member SET updated_at=CURDATE(); SELECT COUNT(*) clan_rows FROM clan; SELECT COUNT(*) clan_member_rows FROM clan_member; SHOW VARIABLES LIKE 'max_connections';"

Write-Host "=== START LANGLA ==="
$out = Join-Path $logDir "langla-server-run.log"
$err = Join-Path $logDir "langla-server-err.log"
Remove-Item $out,$err -Force -ErrorAction SilentlyContinue
$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
$p = Start-Process -FilePath $java -ArgumentList "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`"" -WorkingDirectory $server -RedirectStandardOutput $out -RedirectStandardError $err -PassThru -WindowStyle Hidden
Write-Host "LANGLA_PID=$($p.Id)"
Start-Sleep -Seconds 35

Write-Host "=== PROCESS ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== PORTS ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,3306,27017,2907) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== LOG OUT ==="
if (Test-Path $out) { Get-Content $out -Tail 220 }
Write-Host "=== LOG ERR ==="
if (Test-Path $err) { Get-Content $err -Tail 220 }
