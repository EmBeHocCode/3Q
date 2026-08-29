$ErrorActionPreference = "Continue"
Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== OPEN WINDOWS FIREWALL PORT 2907 ==="
if (-not (Get-NetFirewallRule -Name "LangLa-Game-2907" -ErrorAction SilentlyContinue)) {
  New-NetFirewallRule -Name "LangLa-Game-2907" -DisplayName "LangLa Game 2907" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 2907 | Out-Null
}
Get-NetFirewallRule -Name "LangLa-Game-2907" | Format-List Name,DisplayName,Enabled,Direction,Action

Write-Host "=== PORTS ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in @(80,2907,3306,27017) } |
  Sort-Object LocalPort |
  Format-Table -AutoSize LocalAddress,LocalPort,OwningProcess
