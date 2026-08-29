$ErrorActionPreference = "Continue"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$mongoData = "C:\tools\mongodb-data"
$mongoLogDir = "C:\tools\mongodb-log"
New-Item -ItemType Directory -Force -Path $logDir,$mongoData,$mongoLogDir | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== CLEAN STUCK INSTALL SCRIPTS ONLY ==="
Get-CimInstance Win32_Process | Where-Object {
  ($_.Name -eq "powershell.exe" -and $_.CommandLine -match "langla-install-mongo-start") -or
  ($_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck")
} | ForEach-Object {
  Write-Host "KILL PID=$($_.ProcessId) CMD=$($_.CommandLine)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== START EXISTING MONGODB ==="
$mongod = "C:\Program Files\MongoDB\Server\8.3\bin\mongod.exe"
if (-not (Test-Path $mongod)) { throw "Missing $mongod" }
$mongodLog = Join-Path $mongoLogDir "mongod-direct.log"
$existing = Get-Process mongod -ErrorAction SilentlyContinue
if (-not $existing) {
  $mp = Start-Process -FilePath $mongod -ArgumentList "--dbpath `"$mongoData`" --bind_ip 127.0.0.1 --port 27017 --logpath `"$mongodLog`" --logappend" -PassThru -WindowStyle Hidden
  Write-Host "MONGOD_PID=$($mp.Id)"
  Start-Sleep -Seconds 8
} else {
  Write-Host "MONGOD_ALREADY_RUNNING"
}

Write-Host "=== PORTS AFTER MONGO ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,3306,27017,2907) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== START LANGLA ==="
$out = Join-Path $logDir "langla-server-run.log"
$err = Join-Path $logDir "langla-server-err.log"
Remove-Item $out,$err -Force -ErrorAction SilentlyContinue
$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
$p = Start-Process -FilePath $java -ArgumentList "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`"" -WorkingDirectory $server -RedirectStandardOutput $out -RedirectStandardError $err -PassThru -WindowStyle Hidden
Write-Host "LANGLA_PID=$($p.Id)"
Start-Sleep -Seconds 25

Write-Host "=== LANGLA PROCESS ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== PORTS AFTER LANGLA ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,3306,27017,2907) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== LOG OUT ==="
if (Test-Path $out) { Get-Content $out -Tail 200 }
Write-Host "=== LOG ERR ==="
if (Test-Path $err) { Get-Content $err -Tail 200 }
Write-Host "=== MONGO LOG ==="
if (Test-Path $mongodLog) { Get-Content $mongodLog -Tail 80 }
