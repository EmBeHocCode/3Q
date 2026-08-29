$ErrorActionPreference = "Continue"
$runner = "C:\LangLa\start-langla.ps1"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
New-Item -ItemType Directory -Force -Path (Split-Path $runner),$logDir | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== WRITE FIXED RUNNER ==="
@'
$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"
New-Item -ItemType Directory -Force -Path $logDir | Out-Null

Start-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3

$existing = Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ"
}
if ($existing) {
  "LangLa already running: $($existing[0].ProcessId) $(Get-Date -Format s)" | Out-File -FilePath (Join-Path $logDir "langla-task-status.log") -Append
  exit 0
}

$mysql = "C:\xampp\mysql\bin\mysql.exe"
if (Test-Path $mysql) {
  & $mysql -uroot -e "SET GLOBAL max_connections=1000; SET GLOBAL wait_timeout=28800; SET GLOBAL interactive_timeout=28800;" 2>&1 | Out-File -FilePath (Join-Path $logDir "langla-task-status.log") -Append
  & $mysql -uroot langla -e "UPDATE clan SET updated_at=CURDATE(); UPDATE clan_member SET updated_at=CURDATE();" 2>&1 | Out-File -FilePath (Join-Path $logDir "langla-task-status.log") -Append
}

$out = Join-Path $logDir "langla-server-run.log"
$err = Join-Path $logDir "langla-server-err.log"
$java = "C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"
$args = @("-server","-jar","-Dfile.encoding=UTF-8","out/artifacts/LangLaZ_jar/LangLaZ.jar")
Start-Process -FilePath $java -ArgumentList $args -WorkingDirectory $server -RedirectStandardOutput $out -RedirectStandardError $err -WindowStyle Hidden
"LangLa start requested at $(Get-Date -Format s)" | Out-File -FilePath (Join-Path $logDir "langla-task-status.log") -Append
'@ | Set-Content -Encoding UTF8 -LiteralPath $runner

Write-Host "=== RUN FIXED RUNNER ==="
powershell.exe -NoProfile -ExecutionPolicy Bypass -File $runner
Start-Sleep -Seconds 35

Write-Host "=== STATUS ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | Select-Object ProcessId,Name,CommandLine | Format-List
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,2907,3306,27017) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess

Write-Host "=== LOG TAIL ==="
foreach ($f in @(
  (Join-Path $logDir "langla-task-status.log"),
  (Join-Path $logDir "langla-server-run.log"),
  (Join-Path $logDir "langla-server-err.log")
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content $f -Tail 100 } else { Write-Host "MISSING" }
}
