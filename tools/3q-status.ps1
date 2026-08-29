$ports = @(80,81,8080,9001,8806,6001,14001,20004,3306)
Write-Output '=== D drive ==='
cmd /c subst
Write-Output ''
Write-Output '=== ports ==='
foreach ($p in $ports) {
  $hit = netstat -ano -p tcp | Select-String -Pattern (":$p\s+.*LISTENING")
  if ($hit) { Write-Output "OK   $p  $($hit.Line.Trim())" } else { Write-Output "MISS $p" }
}
Write-Output ''
Write-Output '=== 3Q processes ==='
Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -and ($_.CommandLine -like '*3QVuongGia*' -or $_.CommandLine -like '*phpStudy*' -or $_.CommandLine -like '*apache-tomcat*') } |
  Select-Object ProcessId, Name, CommandLine |
  Format-Table -AutoSize
