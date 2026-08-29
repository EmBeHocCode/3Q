$ErrorActionPreference = "Continue"

Write-Host "DISABLE_LANGLA_BACKGROUND_BEGIN"

Write-Host "SERVICES_MATCH_JAVA_MONGO"
Get-CimInstance Win32_Service |
  Where-Object { $_.Name -match 'mongo|java|lang|la|game' -or $_.PathName -match 'mongo|java|LangLa|LangSuong|LangLaZ' } |
  Select-Object Name, DisplayName, State, StartMode, ProcessId, PathName |
  Format-List

Get-CimInstance Win32_Service |
  Where-Object { $_.Name -match 'mongo|java|lang|game' -or $_.PathName -match 'mongod|LangLaZ.jar' } |
  ForEach-Object {
    Write-Host ("Stopping/disabling service {0} PID={1}" -f $_.Name, $_.ProcessId)
    Stop-Service -Name $_.Name -Force -ErrorAction SilentlyContinue
    Set-Service -Name $_.Name -StartupType Disabled -ErrorAction SilentlyContinue
  }

Write-Host "KILL_UNUSED_BACKGROUND"
Get-CimInstance Win32_Process |
  Where-Object {
    ($_.CommandLine -match 'LangLaZ.jar') -or
    ($_.Name -eq 'mongod.exe')
  } |
  ForEach-Object {
    Write-Host ("Killing PID={0} Name={1} Cmd={2}" -f $_.ProcessId, $_.Name, $_.CommandLine)
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }

Write-Host "DISABLE_LANGLA_BACKGROUND_DONE"
