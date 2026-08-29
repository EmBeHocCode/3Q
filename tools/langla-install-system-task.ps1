$ErrorActionPreference = "Continue"
$runner = "C:\LangLa\start-langla.ps1"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== DELETE BROKEN SERVICE ==="
sc.exe stop LangLaServer | Out-Host
Start-Sleep -Seconds 1
sc.exe delete LangLaServer | Out-Host
Start-Sleep -Seconds 1

Write-Host "=== STOP OLD LANGLA JAVA ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | ForEach-Object {
  Write-Host "KILL PID=$($_.ProcessId)"
  Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
}

Write-Host "=== CREATE SYSTEM SCHEDULED TASK ==="
schtasks.exe /Delete /TN "LangLaServer" /F | Out-Host
$tr = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$runner`""
schtasks.exe /Create /TN "LangLaServer" /SC ONSTART /RU SYSTEM /RL HIGHEST /TR $tr /F | Out-Host

Write-Host "=== RUN TASK NOW ==="
schtasks.exe /Run /TN "LangLaServer" | Out-Host
Start-Sleep -Seconds 45

Write-Host "=== TASK STATUS ==="
schtasks.exe /Query /TN "LangLaServer" /V /FO LIST | Out-Host

Write-Host "=== PROCESSES ==="
Get-CimInstance Win32_Process | Where-Object {
  $_.Name -match "^javaw?\.exe$" -and $_.CommandLine -match "LangLaZ|ServerCheck"
} | Select-Object ProcessId,Name,CommandLine | Format-List

Write-Host "=== PORTS ==="
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
  if (Test-Path $f) { Get-Content $f -Tail 120 } else { Write-Host "MISSING" }
}
