$ErrorActionPreference = "Continue"
cmd /c subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>$null | Out-Null

Write-Host "=== STOP OLD HTTPD ==="
Get-Process httpd -ErrorAction SilentlyContinue | ForEach-Object {
  Write-Host "kill httpd $($_.Id)"
  Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
}
Start-Sleep -Seconds 2

Write-Host "=== APACHE CONFIG TEST ==="
$httpd = "D:\3QVuongGia\phpStudy\Apache\bin\httpd.exe"
& $httpd -t -d "D:/3QVuongGia/phpStudy/Apache" 2>&1

Write-Host "=== START APACHE ==="
Start-Process -FilePath $httpd -ArgumentList '-d "D:/3QVuongGia/phpStudy/Apache"' -WorkingDirectory "D:\3QVuongGia\phpStudy\Apache\bin" -WindowStyle Hidden
Start-Sleep -Seconds 4

Write-Host "=== PROCS / PORT ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "httpd|phpStudy" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List
netstat -ano -p tcp | Select-String ":80\s"

Write-Host "=== LOGIN TEST ==="
foreach ($u in @(
  "http://127.0.0.1/",
  "http://127.0.0.1/login/login.php?userName=meowad&password=123321&version=1.1.5"
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
