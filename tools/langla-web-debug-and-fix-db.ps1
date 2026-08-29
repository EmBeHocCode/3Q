$ErrorActionPreference = "Continue"

$web = "C:\xampp\htdocs\langla"
$config = Join-Path $web "in\config.php"

Write-Host "=== CONFIG BEFORE ==="
if (Test-Path -LiteralPath $config) {
  Get-Content -LiteralPath $config -Raw
} else {
  Write-Host "MISSING $config"
}

Write-Host "=== MYSQL TEST CANDIDATES ==="
$mysqlCandidates = @(
  "C:\xampp\mysql\bin\mysql.exe",
  "C:\xampp\mysql\bin\mariadb.exe"
)
$mysql = $mysqlCandidates | Where-Object { Test-Path -LiteralPath $_ } | Select-Object -First 1
Write-Host "MYSQL_EXE=$mysql"
if ($mysql) {
  foreach ($cred in @("-uroot", "-uroot -proot", "-uroot -p123456", "-ulangla -plangla")) {
    Write-Host "--- $cred"
    cmd /c "`"$mysql`" $cred -e `"select 1; show databases;`" 2>&1"
  }
}

Write-Host "=== HTTP BEFORE ==="
try {
  $r = Invoke-WebRequest -UseBasicParsing "http://127.0.0.1/langla/" -TimeoutSec 8
  $r.Content
} catch {
  $_.Exception.Message
  if ($_.Exception.Response) {
    $sr = New-Object IO.StreamReader($_.Exception.Response.GetResponseStream())
    $sr.ReadToEnd()
  }
}
