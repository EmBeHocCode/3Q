$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null
$root = "D:\3QVuongGia"

Write-Host "=== SUBST ==="
cmd /c subst

Write-Host "=== START BAT FILES ==="
foreach ($p in @(
  "$root\data\usercenter_HD\start.bat",
  "$root\data\cross_android\start.bat",
  "$root\data\server_4001\start.bat",
  "$root\1 - GM.bat",
  "$root\999 - Stop All.bat"
)) {
  Write-Host "--- $p exists=$(Test-Path -LiteralPath $p) ---"
  if (Test-Path -LiteralPath $p) {
    Get-Content -LiteralPath $p -Encoding Default -ErrorAction Continue
  }
}

Write-Host "=== RECENT LOG ENDINGS ==="
$candidates = @()
if (Test-Path "C:\3q-logs") {
  $candidates += Get-ChildItem "C:\3q-logs" -File -ErrorAction SilentlyContinue
}
if (Test-Path $root) {
  $candidates += Get-ChildItem $root -Recurse -File -Include "*.log","*.err","*.txt" -ErrorAction SilentlyContinue |
    Where-Object { $_.LastWriteTime -gt (Get-Date).AddHours(-4) }
}

$candidates |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 15 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) size=$($_.Length) last=$($_.LastWriteTime) ---"
    Select-String -LiteralPath $_.FullName -Pattern "Exception|ERROR|Error|Caused by|Bind|refused|denied|failed|Failed|NumberFormat|Unknown|Access denied|Communications link|SERVER START COMPLETE|Remoting now listens|Started ServerConnector|SEVERE|INFO:" -ErrorAction SilentlyContinue |
      Select-Object -Last 40 |
      ForEach-Object { Write-Host $_.Line }
    Write-Host "--- tail ---"
    Get-Content -LiteralPath $_.FullName -Tail 40 -Encoding Default -ErrorAction SilentlyContinue
  }

Write-Host "=== JAVA/TOMCAT PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|cmd|conhost|tomcat|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize

