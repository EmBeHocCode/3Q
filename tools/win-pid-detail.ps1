$ErrorActionPreference = "Continue"

Write-Host "PID_1088_SERVICES"
Get-CimInstance Win32_Service |
  Where-Object { $_.ProcessId -eq 1088 } |
  Select-Object Name, DisplayName, State, StartMode, ProcessId |
  Format-Table -AutoSize

Write-Host "PID_4608_PROCESS"
Get-CimInstance Win32_Process -Filter "ProcessId=4608" |
  Select-Object ProcessId, Name, CommandLine |
  Format-List

Write-Host "JAVA_PROCESSES"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match '^java' } |
  Select-Object ProcessId, Name, CommandLine |
  Format-List
