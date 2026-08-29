$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== STOP TASK ==="
Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "=== KILL CROSS/S1 JAVA ONLY ==="
$targets = Get-CimInstance Win32_Process |
  Where-Object {
    $_.Name -eq "java.exe" -and (
      $_.CommandLine -like "*D:\3QVuongGia\data\cross_android*" -or
      $_.CommandLine -like "*D:\3QVuongGia\data\server_4001*"
    )
  }
foreach ($p in $targets) {
  Write-Host ("KILL PID " + $p.ProcessId + " " + $p.CommandLine)
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 3

Write-Host "=== START CROSS THEN S1 ==="
$root = "D:\3QVuongGia"
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$root\data\cross_android\start.bat`"" -WorkingDirectory "$root\data\cross_android" -WindowStyle Hidden | Out-Null
Start-Sleep -Seconds 70
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$root\data\server_4001\start.bat`"" -WorkingDirectory "$root\data\server_4001" -WindowStyle Hidden | Out-Null

Write-Host "=== WAIT PORTS 130s ==="
$need = @(20004,8001,14001,6001,9001,80,3306)
$deadline = (Get-Date).AddSeconds(130)
while ((Get-Date) -lt $deadline) {
  $open = @()
  foreach ($port in $need) {
    if (Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue) { $open += $port }
  }
  Write-Host ("OPEN: " + (($open | Sort-Object) -join ","))
  if (($need | Where-Object { $_ -notin $open }).Count -eq 0) { break }
  Start-Sleep -Seconds 10
}

Write-Host "=== PORTS ==="
netstat -ano -p tcp | Select-String ":20004 |:8001 |:14001 |:6001 |:9001 |:80 |:3306 "

Write-Host "=== CROSS/S1 ERRORS TAIL ==="
foreach ($f in @(
  "D:\3QVuongGia\data\cross_android\logs\work.log",
  "D:\3QVuongGia\data\cross_android\logs\error.log",
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -LiteralPath $f -Pattern "serverActor|Actor|akka|AskTimeout|CrossWulin|Exception|ERROR|error|Started|Remoting|20004" -SimpleMatch:$false |
      Select-Object -Last 60 |
      ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  }
}
