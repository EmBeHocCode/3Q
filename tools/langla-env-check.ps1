$ErrorActionPreference = "Continue"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== PORTS ==="
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { @(80,3306,27017,14444,19129,19130,8080,8088) -contains $_.LocalPort } |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Sort-Object LocalPort |
  Format-Table -AutoSize

Write-Host "=== WHERE COMMANDS ==="
foreach ($cmd in @("java","javac","mysql","mysqld","mongod","mongo","mongosh")) {
  Write-Host "--- $cmd ---"
  cmd /c "where $cmd" 2>$null
}

Write-Host "=== JAVA VERSION ==="
cmd /c "java -version" 2>&1

Write-Host "=== COMMON INSTALL PATHS ==="
$paths = @(
  "C:\Program Files\Java",
  "C:\Program Files\Eclipse Adoptium",
  "C:\Program Files\MySQL",
  "C:\Program Files\MariaDB*",
  "C:\Program Files\MongoDB",
  "C:\tools",
  "C:\Users\Administrator\Downloads"
)
foreach ($p in $paths) {
  Write-Host "--- $p ---"
  Get-ChildItem -Path $p -Force -ErrorAction SilentlyContinue |
    Select-Object Name,Mode,Length,LastWriteTime |
    Format-Table -AutoSize
}

Write-Host "=== SERVICES ==="
Get-Service |
  Where-Object { $_.Name -match "mysql|maria|mongo" -or $_.DisplayName -match "mysql|maria|mongo" } |
  Select-Object Name,DisplayName,Status,StartType |
  Format-Table -AutoSize

Write-Host "=== LANG LA CONFIG ==="
Get-Content -LiteralPath "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\config.properties" -Raw
