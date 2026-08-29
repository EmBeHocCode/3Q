$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== TASKS CONTAIN 3Q ==="
Get-ScheduledTask -ErrorAction SilentlyContinue |
  Where-Object { $_.TaskName -like "*3Q*" -or $_.TaskPath -like "*3Q*" } |
  Select-Object TaskName,TaskPath,State |
  Format-Table -AutoSize

Write-Host "=== PORTS LISTEN ==="
Get-NetTCPConnection -LocalPort 80,3306,6001,8001,9001,14001,20004 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== JAVA 3Q PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  Select-Object ProcessId,CommandLine |
  Format-List

Write-Host "=== EXACT LAST 120 S1 WORK ==="
if (Test-Path "D:\3QVuongGia\data\server_4001\logs\work.log") {
  Get-Content -LiteralPath "D:\3QVuongGia\data\server_4001\logs\work.log" -Tail 120
}

Write-Host "=== EXACT LAST 120 S1 ERROR ==="
if (Test-Path "D:\3QVuongGia\data\server_4001\logs\error.log") {
  Get-Content -LiteralPath "D:\3QVuongGia\data\server_4001\logs\error.log" -Tail 120
}

Write-Host "=== EXACT LAST 120 CROSS WORK ==="
if (Test-Path "D:\3QVuongGia\data\cross_android\logs\work.log") {
  Get-Content -LiteralPath "D:\3QVuongGia\data\cross_android\logs\work.log" -Tail 120
}

Write-Host "=== EXACT LAST 120 CROSS ERROR ==="
if (Test-Path "D:\3QVuongGia\data\cross_android\logs\error.log") {
  Get-Content -LiteralPath "D:\3QVuongGia\data\cross_android\logs\error.log" -Tail 120
}

Write-Host "=== C3Q LOGS LAST FILES ==="
Get-ChildItem "C:\3q-logs" -File -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName,LastWriteTime,Length |
  Format-Table -AutoSize
