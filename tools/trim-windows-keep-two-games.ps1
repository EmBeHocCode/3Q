$ErrorActionPreference = "Continue"

Write-Host "TRIM_KEEP_TWO_GAMES_BEGIN"
Write-Host "KEEP javaw LangSuongMu game clients"

$killNames = @(
  "jusched",
  "MicrosoftEdgeUpdate",
  "BraveCrashHandler",
  "BraveCrashHandler64",
  "SearchApp",
  "RuntimeBroker"
)

foreach ($name in $killNames) {
  Get-Process -Name $name -ErrorAction SilentlyContinue |
    ForEach-Object {
      Write-Host ("Killing {0} PID={1}" -f $_.ProcessName,$_.Id)
      Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    }
}

$services = @("edgeupdate","edgeupdatem","WSearch","SysMain","wuauserv","BITS")
foreach ($svcName in $services) {
  $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
  if ($svc) {
    Write-Host ("Stopping/disabling {0}" -f $svcName)
    Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svcName -StartupType Disabled -ErrorAction SilentlyContinue
  }
}

Write-Host "REMOVE_JAVA_UPDATE_RUN"
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v SunJavaUpdateSched /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v SunJavaUpdateSched /f

Write-Host "LOW_PRIORITY_GAME_CLIENTS"
Get-CimInstance Win32_Process |
  Where-Object { $_.CommandLine -match 'C:\\LangLa\\jre\\bin\\javaw.exe.*LangSuongMu.exe' } |
  ForEach-Object {
    $p = Get-Process -Id $_.ProcessId -ErrorAction SilentlyContinue
    if ($p) {
      Write-Host ("Set BelowNormal PID={0}" -f $p.Id)
      $p.PriorityClass = "BelowNormal"
    }
  }

Write-Host "AFTER_CPU_5S"
$p1 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet
Start-Sleep -Seconds 5
$p2 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet
$rows = foreach ($b in $p2) {
  $a = $p1 | Where-Object { $_.Id -eq $b.Id } | Select-Object -First 1
  if ($a -and $null -ne $a.CPU -and $null -ne $b.CPU) {
    [pscustomobject]@{
      Name = $b.ProcessName
      Id = $b.Id
      CpuPct = [math]::Round((($b.CPU - $a.CPU) / 5) * 100 / [Environment]::ProcessorCount, 1)
      MB = [math]::Round($b.WorkingSet / 1MB, 1)
    }
  }
}
$rows | Sort-Object CpuPct -Descending | Select-Object -First 15 | Format-Table -AutoSize

Write-Host "TRIM_KEEP_TWO_GAMES_DONE"
