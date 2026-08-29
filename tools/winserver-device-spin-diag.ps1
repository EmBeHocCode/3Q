$ErrorActionPreference = "Continue"

Write-Host "DEVICE_SPIN_DIAG_BEGIN"
Get-Date

Write-Host "CPU_COUNTERS"
Get-Counter '\Processor(_Total)\% Processor Time','\Processor(_Total)\% Privileged Time','\System\Processor Queue Length','\Memory\Available MBytes' -SampleInterval 1 -MaxSamples 5 |
  ForEach-Object { $_.CounterSamples } |
  Select-Object Path,@{Name="Value";Expression={[math]::Round($_.CookedValue,1)}} |
  Format-Table -AutoSize

Write-Host "TOP_CPU_5S"
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
$rows | Sort-Object CpuPct -Descending | Select-Object -First 20 | Format-Table -AutoSize

Write-Host "DRIVERS_NET_DISPLAY"
Get-CimInstance Win32_PnPSignedDriver |
  Where-Object {
    $_.DeviceName -match 'VirtIO|Red Hat|QXL|NetKVM|Balloon|Ethernet|Display|Intel' -or
    $_.DriverProviderName -match 'Red Hat|VirtIO|Intel'
  } |
  Select-Object DeviceName,DriverProviderName,DriverVersion,InfName |
  Sort-Object DeviceName |
  Format-Table -AutoSize

Write-Host "VIDEO"
Get-CimInstance Win32_VideoController |
  Select-Object Name,AdapterCompatibility,DriverVersion,CurrentHorizontalResolution,CurrentVerticalResolution |
  Format-Table -AutoSize

Write-Host "NETWORK"
Get-CimInstance Win32_NetworkAdapter |
  Where-Object { $_.Name -match 'Intel|VirtIO|Red Hat|Ethernet' -or $_.NetEnabled } |
  Select-Object Name,Manufacturer,NetEnabled,Speed,AdapterType |
  Format-Table -AutoSize

Write-Host "RDP_SESSIONS"
qwinsta

Write-Host "POWER"
powercfg /getactivescheme

Write-Host "JAVA_LEFT"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match '^java' } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "DEVICE_SPIN_DIAG_DONE"
