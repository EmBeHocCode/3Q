$ErrorActionPreference = "Continue"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== DISABLE SCHEDULED TASK ==="
$task = Get-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
if ($task) {
  Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
  Disable-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue | Out-Null
  Get-ScheduledTask -TaskName "3QVuongGiaServer" | Select-Object TaskName,State | Format-Table -AutoSize
} else {
  Write-Host "Task 3QVuongGiaServer not found"
}

Write-Host "=== KILL 3Q PROCESSES ==="
$targets = Get-CimInstance Win32_Process |
  Where-Object {
    ($_.CommandLine -like "*D:\3QVuongGia*") -or
    ($_.ExecutablePath -like "D:\3QVuongGia*")
  }

foreach ($p in $targets) {
  Write-Host ("KILL PID " + $p.ProcessId + " " + $p.Name)
  Write-Host $p.CommandLine
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}

Start-Sleep -Seconds 3

Write-Host "=== REMOVE GAME PORTPROXY 6001 ==="
netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=6001

Write-Host "=== FINAL PORTS ==="
Get-NetTCPConnection -LocalPort 80,3306,6001,8001,8080,9001,14001,20004 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== FINAL 3Q PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object {
    ($_.CommandLine -like "*D:\3QVuongGia*") -or
    ($_.ExecutablePath -like "D:\3QVuongGia*")
  } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== DONE: 3Q GAME SERVER STOPPED ==="
