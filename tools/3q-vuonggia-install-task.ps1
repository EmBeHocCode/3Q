$ErrorActionPreference = "Stop"

$taskName = "3QVuongGiaServer"
$script = "C:\3q-run\3q-vuonggia-service-start.ps1"
$src = "C:\Users\Administrator\Desktop\3q-vuonggia-service-start.ps1"

New-Item -ItemType Directory -Force -Path "C:\3q-run","C:\3q-logs" | Out-Null
Copy-Item -LiteralPath $src -Destination $script -Force

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$script`""
$trigger = New-ScheduledTaskTrigger -AtStartup
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -ExecutionTimeLimit (New-TimeSpan -Hours 0)

Unregister-ScheduledTask -TaskName $taskName -Confirm:$false -ErrorAction SilentlyContinue
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Settings $settings | Out-Null
Start-ScheduledTask -TaskName $taskName

Write-Host "INSTALLED_AND_STARTED $taskName"

