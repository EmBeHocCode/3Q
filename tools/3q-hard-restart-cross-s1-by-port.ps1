$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

$root = "D:\3QVuongGia"

Write-Host "=== STOP TASK ==="
Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Write-Host "=== KILL BY PORT OWNER: 20004/8001/14001 ==="
$ports = @(20004,8001,14001)
$pids = Get-NetTCPConnection -LocalPort $ports -State Listen -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty OwningProcess -Unique |
  Where-Object { $_ -and $_ -ne 0 }

foreach ($procId in $pids) {
  Write-Host ("KILL PID " + $procId)
  Get-CimInstance Win32_Process -Filter "ProcessId=$procId" |
    Select-Object ProcessId,Name,CommandLine |
    Format-List
  Stop-Process -Id $procId -Force -ErrorAction SilentlyContinue
}

Start-Sleep -Seconds 5

Write-Host "=== VERIFY CLOSED ==="
Get-NetTCPConnection -LocalPort $ports -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize

Write-Host "=== START CROSS ==="
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$root\data\cross_android\start.bat`"" -WorkingDirectory "$root\data\cross_android" -WindowStyle Hidden | Out-Null

Write-Host "=== WAIT CROSS 90s ==="
$deadline = (Get-Date).AddSeconds(90)
while ((Get-Date) -lt $deadline) {
  $open = Get-NetTCPConnection -LocalPort 20004 -State Listen -ErrorAction SilentlyContinue
  if ($open) { Write-Host "CROSS 20004 OPEN"; break }
  Write-Host "waiting cross..."
  Start-Sleep -Seconds 10
}
Start-Sleep -Seconds 25

Write-Host "=== START S1 ==="
Start-Process -FilePath "cmd.exe" -ArgumentList "/c `"$root\data\server_4001\start.bat`"" -WorkingDirectory "$root\data\server_4001" -WindowStyle Hidden | Out-Null

Write-Host "=== WAIT S1 150s ==="
$need = @(20004,8001,14001,6001,9001,80,3306)
$deadline = (Get-Date).AddSeconds(150)
while ((Get-Date) -lt $deadline) {
  $openPorts = @()
  foreach ($port in $need) {
    if (Get-NetTCPConnection -LocalPort $port -State Listen -ErrorAction SilentlyContinue) { $openPorts += $port }
  }
  Write-Host ("OPEN: " + (($openPorts | Sort-Object) -join ","))
  if (($need | Where-Object { $_ -notin $openPorts }).Count -eq 0) { break }
  Start-Sleep -Seconds 10
}

Write-Host "=== FINAL PORT OWNERS ==="
Get-NetTCPConnection -LocalPort 20004,8001,14001,6001 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== JAVA OWNERS ==="
$ownerPids = Get-NetTCPConnection -LocalPort 20004,8001,14001 -State Listen -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty OwningProcess -Unique
foreach ($procId in $ownerPids) {
  Get-CimInstance Win32_Process -Filter "ProcessId=$procId" |
    Select-Object ProcessId,Name,CommandLine |
    Format-List
}

Write-Host "=== CHECK CROSS TIMEOUT LATEST ==="
foreach ($f in @(
  "D:\3QVuongGia\data\cross_android\logs\work.log",
  "D:\3QVuongGia\data\cross_android\logs\error.log",
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Select-String -LiteralPath $f -Pattern "serverActor|AskTimeout|CrossWulin|Remoting|Started|ERROR|Exception" -SimpleMatch:$false |
      Select-Object -Last 50 |
      ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  }
}
