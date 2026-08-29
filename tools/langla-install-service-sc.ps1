$ErrorActionPreference = "Continue"
$runner = "C:\LangLa\start-langla.ps1"
$service = "LangLaServer"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== REMOVE OLD SERVICE IF EXISTS ==="
sc.exe stop $service | Out-Host
Start-Sleep -Seconds 2
sc.exe delete $service | Out-Host
Start-Sleep -Seconds 2

Write-Host "=== CREATE SERVICE ==="
$bin = "powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"$runner`""
sc.exe create $service binPath= "$bin" start= auto DisplayName= "LangLa Server" | Out-Host
sc.exe description $service "Starts LangLa game server" | Out-Host

Write-Host "=== START SERVICE ==="
sc.exe start $service | Out-Host
Start-Sleep -Seconds 40

Write-Host "=== STATUS ==="
sc.exe query $service | Out-Host
Get-Service -Name "LangLaMongoDB" -ErrorAction SilentlyContinue | Format-List Status,Name,StartType
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
