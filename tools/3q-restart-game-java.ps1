$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== STOP TASK ==="
Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "=== KILL 3Q JAVA ==="
$javaProcs = Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" }
foreach ($p in $javaProcs) {
  Write-Host "KILL java PID $($p.ProcessId)"
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 3

Write-Host "=== START TASK ==="
Start-ScheduledTask -TaskName "3QVuongGiaServer"

Write-Host "=== WAIT PORTS ==="
$deadline = (Get-Date).AddSeconds(130)
$need = @(8080,9001,20004,14001)
while ((Get-Date) -lt $deadline) {
  $open = @()
  foreach ($p in $need) {
    if (Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue) {
      $open += $p
    }
  }
  Write-Host ("OPEN: " + (($open | Sort-Object) -join ","))
  if (($need | Where-Object { $_ -notin $open }).Count -eq 0) { break }
  Start-Sleep -Seconds 10
}

Write-Host "=== FINAL PORTS ==="
netstat -ano -p tcp | Select-String ":8080|:9001|:20004|:14001|:6001"

Write-Host "=== JAVA PROCS ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== LATEST SERVICE LOG ==="
Get-ChildItem C:\3q-logs\service-start-*.log -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content $_.FullName -Tail 80
  }

Write-Host "=== S1 LOG TAIL ==="
foreach ($f in @("D:\3QVuongGia\data\server_4001\logs\work.log","D:\3QVuongGia\data\server_4001\logs\error.log")) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content $f -Tail 60 } else { Write-Host "MISSING" }
}
