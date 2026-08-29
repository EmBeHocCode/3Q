$ErrorActionPreference = "Continue"

$logs = @(
  "C:\Users\Administrator\Desktop\uc-run.log",
  "C:\Users\Administrator\Desktop\cross-run.log",
  "C:\Users\Administrator\Desktop\s1-run.log"
)

foreach ($log in $logs) {
  Write-Host "=== $log ==="
  if (!(Test-Path $log)) {
    Write-Host "MISSING"
    continue
  }
  $item = Get-Item $log
  Write-Host "SIZE=$($item.Length) LAST=$($item.LastWriteTime)"
  Write-Host "--- ERRORS ---"
  Select-String -Path $log -Pattern "Exception|ERROR|Error|Caused by|Address already|Bind|refused|denied|failed|Failed|NumberFormat|Unknown|Access denied|Communications link" -ErrorAction SilentlyContinue |
    Select-Object -Last 30 |
    ForEach-Object { Write-Host $_.Line }
  Write-Host "--- TAIL ---"
  Get-Content $log -Tail 60 -ErrorAction SilentlyContinue
}
