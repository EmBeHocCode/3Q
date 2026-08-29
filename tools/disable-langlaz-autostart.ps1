$ErrorActionPreference = "Continue"

Write-Host "DISABLE_LANGLAZ_AUTOSTART_BEGIN"

Write-Host "KILL_CURRENT_LANGLAZ"
Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -match 'LangLaZ\.jar' } |
  ForEach-Object {
    Write-Host ("Killing PID={0} Cmd={1}" -f $_.ProcessId,$_.CommandLine)
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }

Write-Host "SERVICES_MATCH"
Get-CimInstance Win32_Service |
  Where-Object { $_.PathName -match 'LangLaZ\.jar|LangLa|java' -or $_.Name -match 'LangLa|java' } |
  Select-Object Name,DisplayName,State,StartMode,ProcessId,PathName |
  Format-List

Get-CimInstance Win32_Service |
  Where-Object { $_.PathName -match 'LangLaZ\.jar' -or $_.Name -match 'LangLa' } |
  ForEach-Object {
    Write-Host ("Stopping/disabling service {0}" -f $_.Name)
    Stop-Service -Name $_.Name -Force -ErrorAction SilentlyContinue
    Set-Service -Name $_.Name -StartupType Disabled -ErrorAction SilentlyContinue
  }

Write-Host "SCHEDULED_TASKS_MATCH"
Get-ScheduledTask -ErrorAction SilentlyContinue |
  Where-Object { $_.TaskName -match 'LangLa|java' -or $_.TaskPath -match 'LangLa|java' } |
  ForEach-Object {
    Write-Host ("Disabling task {0}{1}" -f $_.TaskPath,$_.TaskName)
    Disable-ScheduledTask -TaskName $_.TaskName -TaskPath $_.TaskPath -ErrorAction SilentlyContinue | Out-Null
  }

Write-Host "STARTUP_RUN_KEYS"
$runKeys = @(
  "HKLM:\Software\Microsoft\Windows\CurrentVersion\Run",
  "HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
)
foreach ($key in $runKeys) {
  if (Test-Path $key) {
    Get-ItemProperty $key |
      Select-Object * |
      Format-List
  }
}

Write-Host "JAVA_LEFT"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match '^java' } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "DISABLE_LANGLAZ_AUTOSTART_DONE"
