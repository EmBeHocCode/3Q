$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== HTTPD PROCESS ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "httpd|apache|phpStudy" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== FIND APACHE CONFIGS ==="
$configs = Get-ChildItem "D:\3QVuongGia\phpStudy" -Recurse -File -ErrorAction SilentlyContinue |
  Where-Object { $_.Name -match "httpd.*\.conf$|vhost.*\.conf$|apache.*\.conf$" }
$configs | Select-Object FullName,Length,LastWriteTime | Format-Table -AutoSize

Write-Host "=== CONFIG HITS ==="
foreach ($c in $configs) {
  $hits = Select-String -Path $c.FullName -Pattern "DocumentRoot|Alias|Listen|VirtualHost|htdocs|WWW|3QVuongGia|login" -ErrorAction SilentlyContinue
  if ($hits) {
    Write-Host "--- $($c.FullName) ---"
    $hits | Select-Object -First 80 | ForEach-Object { "$($_.LineNumber):$($_.Line)" }
  }
}

Write-Host "=== LOCAL HTTP TESTS BEFORE ==="
foreach ($u in @(
  "http://127.0.0.1/",
  "http://127.0.0.1/login/login.php?userName=meowad&password=123321&version=1.1.5",
  "http://127.0.0.1:8080/zjh/",
  "http://127.0.0.1:8080/login/login.php?userName=meowad&password=123321&version=1.1.5"
)) {
  Write-Host "--- $u ---"
  try {
    $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 8
    Write-Host "HTTP $($r.StatusCode) len=$($r.Content.Length)"
    Write-Host ($r.Content.Substring(0, [Math]::Min(220, $r.Content.Length)))
  } catch {
    Write-Host "ERROR $($_.Exception.Message)"
  }
}

$httpd = $configs | Where-Object { $_.FullName -match "Apache\\conf\\httpd\.conf$" } | Select-Object -First 1
if ($httpd) {
  $conf = $httpd.FullName
  $text = Get-Content $conf -Raw
  $marker = "# 3Q Codex login alias"
  if ($text -notmatch [regex]::Escape($marker)) {
    Copy-Item $conf "$conf.bak-codex-login-$(Get-Date -Format yyyyMMdd-HHmmss)"
    $append = @"

$marker
Alias /login/ "D:/3QVuongGia/www/login/"
<Directory "D:/3QVuongGia/www/login/">
    Options Indexes FollowSymLinks
    AllowOverride All
    Require all granted
</Directory>
"@
    Add-Content -Path $conf -Value $append -Encoding ASCII
    Write-Host "PATCHED $conf"
  } else {
    Write-Host "ALREADY PATCHED $conf"
  }
} else {
  Write-Host "MISSING Apache conf, cannot patch alias"
}

Write-Host "=== RESTART APACHE/PHPSTUDY ==="
$httpdProcs = Get-CimInstance Win32_Process | Where-Object { $_.Name -match "httpd" }
foreach ($p in $httpdProcs) {
  Write-Host "KILL httpd PID $($p.ProcessId)"
  Stop-Process -Id $p.ProcessId -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 2
$apacheExe = "D:\3QVuongGia\phpStudy\Apache\bin\httpd.exe"
if (Test-Path $apacheExe) {
  Start-Process -FilePath $apacheExe -WorkingDirectory "D:\3QVuongGia\phpStudy\Apache\bin" -WindowStyle Hidden
  Start-Sleep -Seconds 3
}

Write-Host "=== PORT 80 AFTER ==="
netstat -ano -p tcp | Select-String ":80\s"

Write-Host "=== LOCAL HTTP TESTS AFTER ==="
foreach ($u in @(
  "http://127.0.0.1/login/login.php?userName=meowad&password=123321&version=1.1.5",
  "http://127.0.0.1/login/login.php?userName=codextest&password=123321&version=1.1.5"
)) {
  Write-Host "--- $u ---"
  try {
    $r = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 8
    Write-Host "HTTP $($r.StatusCode) len=$($r.Content.Length)"
    Write-Host $r.Content
  } catch {
    Write-Host "ERROR $($_.Exception.Message)"
  }
}
