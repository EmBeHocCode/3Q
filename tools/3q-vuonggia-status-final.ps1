$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

Write-Host "=== TASK ==="
Get-ScheduledTask -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue |
  Select-Object TaskName,State |
  Format-Table -AutoSize
Get-ScheduledTaskInfo -TaskName "3QVuongGiaServer" -ErrorAction SilentlyContinue |
  Select-Object LastRunTime,LastTaskResult,NextRunTime |
  Format-List

Write-Host "=== LISTENING PORTS ==="
$ports = @(80,8080,9001,14001,20004,3306,3390,2222)
foreach ($p in $ports) {
  $hit = netstat -ano -p tcp | Select-String -Pattern (":$p\s+.*LISTENING")
  if ($hit) { Write-Host "OK   $p  $($hit.Line.Trim())" }
  else { Write-Host "MISS $p" }
}

Write-Host "=== PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-Table -AutoSize

Write-Host "=== HTTP LOCAL ==="
foreach ($url in @("http://127.0.0.1/","http://127.0.0.1:8080/zjh/")) {
  try {
    $r = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 10
    Write-Host "$url => $($r.StatusCode) len=$($r.Content.Length)"
  } catch {
    Write-Host "$url => ERROR $($_.Exception.Message)"
  }
}

Write-Host "=== LATEST SERVICE LOG ==="
Get-ChildItem "C:\3q-logs" -Filter "service-start-*.log" -ErrorAction SilentlyContinue |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 1 |
  ForEach-Object {
    Write-Host "--- $($_.FullName) ---"
    Get-Content -LiteralPath $_.FullName -Tail 80
  }

