$ErrorActionPreference = "Stop"

cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

$cfg = "D:\3QVuongGia\data\server_4001\config\global.config"
if (!(Test-Path $cfg)) { throw "Missing $cfg" }

$stamp = Get-Date -Format "yyyyMMdd-HHmmss"
$bak = "$cfg.bak-$stamp"
Copy-Item -LiteralPath $cfg -Destination $bak -Force

$text = Get-Content -LiteralPath $cfg -Raw
$text = $text -replace "(?m)^server\.identity=.*$", "server.identity=4001"
$text = $text -replace "(?m)^server\.mergeServerIds=.*$", "server.mergeServerIds=4001"
Set-Content -LiteralPath $cfg -Encoding ASCII -Value $text

Write-Host "=== BACKUP ==="
Write-Host $bak

Write-Host "=== NEW CONFIG ==="
Select-String -LiteralPath $cfg -Pattern "server.identity|server.mergeServerIds|net.server.port|net.cross.server.port|cross.server.address|static.bonecp.jdbcUrl" |
  ForEach-Object { $_.Line }

Write-Host "=== RESTART JAVA GAME ==="
Stop-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  ForEach-Object {
    Write-Host ("KILL java PID " + $_.ProcessId)
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }
Start-Sleep -Seconds 3

Start-ScheduledTask -TaskName "3QVuongGiaServer"

Write-Host "=== WAIT 150s ==="
$need = @(80,3306,8080,9001,20004,14001)
$deadline = (Get-Date).AddSeconds(150)
while ((Get-Date) -lt $deadline) {
  $open = @()
  foreach ($p in $need) {
    if (Get-NetTCPConnection -LocalPort $p -State Listen -ErrorAction SilentlyContinue) { $open += $p }
  }
  Write-Host ("OPEN: " + (($open | Sort-Object) -join ","))
  if (($need | Where-Object { $_ -notin $open }).Count -eq 0) { break }
  Start-Sleep -Seconds 10
}

Write-Host "=== FINAL PORTS ==="
netstat -ano -p tcp | Select-String ":80 |:3306 |:8080 |:9001 |:20004 |:14001 "

Write-Host "=== S1 TAIL ==="
foreach ($f in @("D:\3QVuongGia\data\server_4001\logs\work.log","D:\3QVuongGia\data\server_4001\logs\error.log")) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Tail 40 }
}
