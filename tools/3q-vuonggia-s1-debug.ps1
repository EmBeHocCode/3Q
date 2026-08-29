$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null
$root = "D:\3QVuongGia"

Write-Host "=== LISTENING 3Q PORTS ==="
netstat -ano -p tcp |
  Select-String -Pattern ":(80|81|8080|8088|9001|6001|8001|8806|14001|20004|23701|23702|23703|23799|3306)\s+.*LISTENING" |
  ForEach-Object { Write-Host $_.Line.Trim() }

Write-Host "=== S1/CROSS/UC JAVA COMMANDS ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -eq "java.exe" } |
  Select-Object ProcessId,CommandLine |
  Format-List

Write-Host "=== CONFIG PORT HITS ==="
foreach ($dir in @("$root\data\server_4001\config","$root\data\cross_android\config","$root\data\usercenter_HD\config")) {
  Write-Host "--- $dir ---"
  if (Test-Path -LiteralPath $dir) {
    Get-ChildItem -LiteralPath $dir -Recurse -File -ErrorAction SilentlyContinue |
      Select-String -Pattern "14001|20004|6001|8001|8806|9001|23701|127.0.0.1|104.248.157.207" -ErrorAction SilentlyContinue |
      Select-Object -First 120 |
      ForEach-Object { Write-Host "$($_.Path):$($_.LineNumber): $($_.Line)" }
  }
}

Write-Host "=== S1 RECENT LOG ERROR/TAIL ==="
$s1Logs = @()
if (Test-Path "$root\data\server_4001\logs") {
  $s1Logs += Get-ChildItem "$root\data\server_4001\logs" -File -ErrorAction SilentlyContinue
}
if (Test-Path "C:\3q-logs") {
  $s1Logs += Get-ChildItem "C:\3q-logs" -File -Filter "s114001-*.out.log" -ErrorAction SilentlyContinue
  $s1Logs += Get-ChildItem "C:\3q-logs" -File -Filter "s114001-*.err.log" -ErrorAction SilentlyContinue
}
$s1Logs |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 8 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) size=$($_.Length) last=$($_.LastWriteTime) ---"
    Select-String -LiteralPath $_.FullName -Pattern "Exception|ERROR|Error|Caused by|Bind|refused|denied|failed|Failed|NumberFormat|Unknown|Access denied|Communications link|SERVER START COMPLETE|Remoting now listens|Started ServerConnector|OutOfMemory" -ErrorAction SilentlyContinue |
      Select-Object -Last 80 |
      ForEach-Object { Write-Host $_.Line }
    Write-Host "--- tail ---"
    Get-Content -LiteralPath $_.FullName -Tail 80 -Encoding Default -ErrorAction SilentlyContinue
  }

Write-Host "=== TASK LOG TAIL ==="
Get-ChildItem "C:\3q-logs" -Filter "service-start-*.log" -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -Tail 120
  }

