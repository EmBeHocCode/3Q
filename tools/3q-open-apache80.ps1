$ErrorActionPreference = "Continue"

New-NetFirewallRule -Name "3Q_Apache80" -DisplayName "3Q Apache HTTP 80" -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 80 -ErrorAction SilentlyContinue | Out-Null

Write-Host "=== FIREWALL ==="
Get-NetFirewallRule -Name "3Q_Apache80" -ErrorAction SilentlyContinue |
  Select-Object Name,Enabled,Direction,Action |
  Format-Table -AutoSize

Write-Host "=== PORT80 ==="
netstat -ano -p tcp | Select-String ":80\s"

Write-Host "=== LOCAL LOGIN ==="
$u = "http://127.0.0.1/login/login.php?userName=meowad&password=123321&version=1.1.5"
try {
  $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 8
  Write-Host "HTTP $($r.StatusCode)"
  Write-Host $r.Content
} catch {
  Write-Host "ERROR $($_.Exception.Message)"
}
