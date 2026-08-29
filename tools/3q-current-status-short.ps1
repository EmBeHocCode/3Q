$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== TASK ==="
Get-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue |
  Select-Object TaskName,State |
  Format-Table -AutoSize

Write-Host "=== PORTS ==="
Get-NetTCPConnection -LocalPort 80,3306,6001,8001,9001,14001,20004 -State Listen -ErrorAction SilentlyContinue |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== JAVA ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" -and $_.CommandLine -like "*D:\3QVuongGia*" } |
  Select-Object ProcessId,CommandLine |
  Format-List

Write-Host "=== PORTPROXY ==="
netsh interface portproxy show all

Write-Host "=== LAST LOG FILES ==="
$paths = @(
  "D:\3QVuongGia\data\server_4001\logs",
  "D:\3QVuongGia\data\cross_android\logs",
  "C:\3q-logs"
)
foreach ($path in $paths) {
  Write-Host "--- $path ---"
  Get-ChildItem $path -File -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending |
    Select-Object -First 8 FullName,LastWriteTime,Length |
    Format-Table -AutoSize
}

Write-Host "=== FATAL MATCHES LAST 200 ==="
$files = @(
  "D:\3QVuongGia\data\server_4001\logs\work.log",
  "D:\3QVuongGia\data\server_4001\logs\error.log",
  "D:\3QVuongGia\data\cross_android\logs\work.log",
  "D:\3QVuongGia\data\cross_android\logs\error.log"
)
$pattern = "AskTimeout|serverActor|CrossWulin|Destroying|shutdown|Connection pool|BindException|Address already|Exception|ERROR|error|Started @|ServerInfoProvider"
foreach ($f in $files) {
  Write-Host "--- $f ---"
  if (Test-Path $f) {
    Get-Content -LiteralPath $f -Tail 220 |
      Select-String -Pattern $pattern -SimpleMatch:$false |
      ForEach-Object { $_.Line }
  } else {
    Write-Host "MISSING"
  }
}
