$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"

Write-Host "=== LISTEN PORTS ==="
$ports = @(80,81,8080,8088,9001,6001,8001,8806,14001,20004,23701,23702,23703,23799)
Get-NetTCPConnection -State Listen |
  Where-Object { $ports -contains $_.LocalPort } |
  Sort-Object LocalPort |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize

Write-Host "=== PROCESS SUMMARY ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  ForEach-Object {
    [pscustomobject]@{
      Name=$_.Name
      PID=$_.ProcessId
      Command=($_.CommandLine -replace "\s+"," ")
    }
  } |
  Format-Table -AutoSize

Write-Host "=== LOCAL HTTP ==="
foreach ($url in @("http://127.0.0.1/","http://127.0.0.1:8080/zjh/","http://127.0.0.1:81/vip")) {
  try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 8
    Write-Host "$url => $($r.StatusCode) $($r.StatusDescription) len=$($r.Content.Length)"
  } catch {
    Write-Host "$url => ERROR $($_.Exception.Message)"
  }
}

Write-Host "OK_VERIFY_DONE"
