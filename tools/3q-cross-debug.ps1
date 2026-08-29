$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== PORTS ==="
Get-NetTCPConnection -LocalPort 20004,14001,8001,6001 -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,RemoteAddress,RemotePort,State,OwningProcess |
  Sort-Object LocalPort,State |
  Format-Table -AutoSize

Write-Host "=== PROCESS 20004/8001 ==="
$pids = Get-NetTCPConnection -LocalPort 20004,8001,14001 -State Listen -ErrorAction SilentlyContinue |
  Select-Object -ExpandProperty OwningProcess -Unique
foreach ($pid in $pids) {
  Get-CimInstance Win32_Process -Filter "ProcessId=$pid" |
    Select-Object ProcessId,Name,CommandLine |
    Format-List
}

Write-Host "=== CROSS START/CONFIG ==="
foreach ($f in @(
  "D:\3QVuongGia\data\cross_android\start.bat",
  "D:\3QVuongGia\data\cross_android\config\global.config",
  "D:\3QVuongGia\data\cross_android\config\global.config.gs",
  "D:\3QVuongGia\data\cross_android\config\application.conf",
  "D:\3QVuongGia\data\cross_android\config\server.conf"
)) {
  Write-Host "--- $f ---"
  if (Test-Path $f) { Get-Content -LiteralPath $f -Raw } else { Write-Host "MISSING" }
}

Write-Host "=== CROSS RECENT LOG FILES ==="
Get-ChildItem "D:\3QVuongGia\data\cross_android" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -in ".log",".txt",".out",".err" -or $_.Name -match "log|error|work" } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName,LastWriteTime,Length |
  Format-Table -AutoSize

Write-Host "=== CROSS LOG MATCHES ==="
$patterns = "serverActor|Actor|akka|20004|14001|4001|5001|Exception|ERROR|error|timeout|Wulin|Cross"
$files = Get-ChildItem "D:\3QVuongGia\data\cross_android" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { ($_.Extension -in ".log",".txt",".out",".err" -or $_.Name -match "log|error|work") -and $_.Length -lt 30000000 } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 8
foreach ($f in $files) {
  Write-Host "--- $($f.FullName) ---"
  Select-String -LiteralPath $f.FullName -Pattern $patterns -SimpleMatch:$false -ErrorAction SilentlyContinue |
    Select-Object -Last 100 |
    ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  Write-Host "--- tail ---"
  Get-Content -LiteralPath $f.FullName -Tail 80 -ErrorAction SilentlyContinue
}

Write-Host "=== C3Q LOGS CROSS OUT ==="
Get-ChildItem "C:\3q-logs" -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "cross|s1|14001|20004" } |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 8 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Select-String -LiteralPath $_.FullName -Pattern $patterns -SimpleMatch:$false -ErrorAction SilentlyContinue |
      Select-Object -Last 80 |
      ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  }
