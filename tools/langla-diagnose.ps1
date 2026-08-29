$ErrorActionPreference = "Continue"

$root = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== ROOT ==="
if (!(Test-Path $root)) {
  Write-Host "MISSING $root"
  exit 1
}
Get-ChildItem -LiteralPath $root -Force | Select-Object Name,Mode,Length,LastWriteTime | Format-Table -AutoSize

Write-Host "=== TOP FILES ==="
Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object {
    $_.Name -match "readme|setup|huong|hướng|config|properties|bat|sql|jar|mongodb|mongo|mysql|start|run|server"
  } |
  Select-Object -First 120 FullName,Length,LastWriteTime |
  Format-Table -AutoSize

Write-Host "=== CONFIG SNIPPETS ==="
$files = Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Extension -in ".properties",".conf",".config",".ini",".txt",".bat",".sh",".xml" } |
  Select-Object -First 80

foreach ($f in $files) {
  Write-Host "--- $($f.FullName) ---"
  Select-String -LiteralPath $f.FullName -Pattern "host|port|mysql|mongo|mongodb|db|password|localhost|127\.0\.0\.1|java|jar|game|server|web|ip" -SimpleMatch:$false -ErrorAction SilentlyContinue |
    Select-Object -First 50 |
    ForEach-Object { "$($_.LineNumber):$($_.Line)" }
}

Write-Host "=== CURRENT LISTEN PORTS ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { @(80,81,82,3306,27017,8080,8081,8082,8088,8888,14444,19129,19130,19131,19132,19133,19134,19135,19136,19137,19138,19139,19140) -contains $_.LocalPort } |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== INSTALLED SERVICES LIKELY ==="
Get-Service |
  Where-Object { $_.Name -match "mysql|mongo|apache|nginx|java" -or $_.DisplayName -match "mysql|mongo|apache|nginx|java" } |
  Select-Object Name,DisplayName,Status,StartType |
  Format-Table -AutoSize

Write-Host "=== JAVA/MYSQL/MONGO COMMANDS ==="
foreach ($cmd in @("java","mysql","mongod","mongo","mongosh")) {
  Write-Host "--- $cmd ---"
  cmd /c "where $cmd" 2>$null
}
