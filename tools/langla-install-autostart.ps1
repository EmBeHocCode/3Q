$ErrorActionPreference = "Continue"

$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
$runner = "C:\LangLa\start-langla.ps1"
$mongoData = "C:\tools\mongodb-data"
$mongoLogDir = "C:\tools\mongodb-log"
$mongoLog = Join-Path $mongoLogDir "mongod-service.log"
$mongod = "C:\Program Files\MongoDB\Server\8.3\bin\mongod.exe"

New-Item -ItemType Directory -Force -Path (Split-Path $runner),$logDir,$mongoData,$mongoLogDir | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== STOP DUPLICATE LANGLA JAVA ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | ForEach-Object {
  Write-Host "KILL PID=$($_.ProcessId)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== INSTALL MONGO SERVICE ==="
if (-not (Test-Path $mongod)) { throw "Missing MongoDB: $mongod" }
if (-not (Get-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue)) {
  & $mongod --dbpath $mongoData --bind_ip 127.0.0.1 --port 27017 --logpath $mongoLog --logappend --serviceName "LangLaMongoDB" --serviceDisplayName "LangLa MongoDB" --install
}
Set-Service -Name "LangLaMongoDB" -StartupType Automatic -ErrorAction SilentlyContinue
Start-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 5

Write-Host "=== WRITE LANGLA RUNNER ==="
@"
`$ErrorActionPreference = "Continue"
`$server = "$server"
`$logDir = "$logDir"
New-Item -ItemType Directory -Force -Path `$logDir | Out-Null

if (-not (Get-Process mongod -ErrorAction SilentlyContinue)) {
  Start-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue
  Start-Sleep -Seconds 5
}

`$existing = Get-CimInstance Win32_Process | Where-Object {
  `$_.Name -match "^javaw?\.exe$" -and `$_.CommandLine -match "LangLaZ"
}
if (`$existing) {
  "LangLa already running: " + (`$existing | Select-Object -ExpandProperty ProcessId -First 1) | Out-File -FilePath (Join-Path `$logDir "langla-task-status.log") -Append
  exit 0
}

`$mysql = "C:\xampp\mysql\bin\mysql.exe"
if (Test-Path `$mysql) {
  & `$mysql -uroot -e "SET GLOBAL max_connections=1000; SET GLOBAL wait_timeout=28800; SET GLOBAL interactive_timeout=28800;" 2>&1 | Out-File -FilePath (Join-Path `$logDir "langla-task-status.log") -Append
  & `$mysql -uroot langla -e "UPDATE clan SET updated_at=CURDATE(); UPDATE clan_member SET updated_at=CURDATE();" 2>&1 | Out-File -FilePath (Join-Path `$logDir "langla-task-status.log") -Append
}

`$out = Join-Path `$logDir "langla-server-run.log"
`$err = Join-Path `$logDir "langla-server-err.log"
`$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
Start-Process -FilePath `$java -ArgumentList "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`"" -WorkingDirectory `$server -RedirectStandardOutput `$out -RedirectStandardError `$err -WindowStyle Hidden
"LangLa start requested at $(Get-Date -Format s)" | Out-File -FilePath (Join-Path `$logDir "langla-task-status.log") -Append
"@ | Set-Content -Encoding UTF8 -LiteralPath $runner

Write-Host "RUNNER=$runner"

Write-Host "=== CREATE SCHEDULED TASK ==="
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$runner`""
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "Administrator" -LogonType Password -RunLevel Highest
try {
  Register-ScheduledTask -TaskName "LangLaServer" -Action $action -Trigger $trigger -Principal $principal -Force | Out-Null
} catch {
  Write-Host "Password principal failed, fallback InteractiveToken: $($_.Exception.Message)"
  $principal2 = New-ScheduledTaskPrincipal -UserId "Administrator" -LogonType InteractiveToken -RunLevel Highest
  Register-ScheduledTask -TaskName "LangLaServer" -Action $action -Trigger $trigger -Principal $principal2 -Force | Out-Null
}

Write-Host "=== RUN TASK NOW ==="
Start-ScheduledTask -TaskName "LangLaServer"
Start-Sleep -Seconds 35

Write-Host "=== STATUS ==="
Get-ScheduledTask -TaskName "LangLaServer" | Format-List TaskName,State
Get-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue | Format-List Status,Name,StartType
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | Select-Object ProcessId,Name,CommandLine | Format-List
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,2907,3306,27017) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== LOG TAIL ==="
if (Test-Path (Join-Path $logDir "langla-server-run.log")) { Get-Content (Join-Path $logDir "langla-server-run.log") -Tail 80 }
if (Test-Path (Join-Path $logDir "langla-server-err.log")) { Get-Content (Join-Path $logDir "langla-server-err.log") -Tail 80 }
