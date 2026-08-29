$ErrorActionPreference = "Continue"

Write-Host "KILL_LANGLAZ_BEGIN"
Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -match 'LangLaZ\.jar' } |
  ForEach-Object {
    Write-Host ("Killing PID={0} Name={1} Cmd={2}" -f $_.ProcessId,$_.Name,$_.CommandLine)
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }

Write-Host "JAVA_LEFT"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match '^java' } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "KILL_LANGLAZ_DONE"
