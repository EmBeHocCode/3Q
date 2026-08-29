$ErrorActionPreference = "Continue"

Write-Host "RESTART_SSHD_BEGIN"
Restart-Service sshd -Force
Start-Sleep -Seconds 2
Get-Service sshd | Select-Object Name,Status,StartType | Format-Table -AutoSize
Write-Host "PATH_MACHINE"
[Environment]::GetEnvironmentVariable("Path", "Machine")
Write-Host "RESTART_SSHD_DONE"
