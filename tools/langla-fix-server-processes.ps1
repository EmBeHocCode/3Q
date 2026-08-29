$ErrorActionPreference = "Continue"

Write-Host "=== BEFORE JAVA ==="
$java = Get-CimInstance Win32_Process | Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -match "LangLaZ_jar" }
$java | Select-Object ProcessId,CommandLine | Format-List

$listeners = netstat -ano | Select-String ":2907" | Select-String "LISTENING"
Write-Host "LISTENERS:"
$listeners

$listenerPid = $null
foreach ($line in $listeners) {
  $parts = ($line.ToString() -split "\s+") | Where-Object { $_ }
  $listenerPid = [int]$parts[-1]
}
Write-Host "KEEP_PID=$listenerPid"

foreach ($p in $java) {
  if ($listenerPid -and $p.ProcessId -ne $listenerPid) {
    Write-Host "STOP_EXTRA_JAVA PID=$($p.ProcessId)"
    Stop-Process -Id $p.ProcessId -Force
  }
}

Start-Sleep -Seconds 2

Write-Host "=== AFTER JAVA ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -match "LangLaZ_jar" } |
  Select-Object ProcessId,CommandLine |
  Format-List

Write-Host "=== PORTS ==="
netstat -ano | Select-String ":2907"
