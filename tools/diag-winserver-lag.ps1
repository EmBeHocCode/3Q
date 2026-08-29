$ErrorActionPreference = "Continue"

Write-Host "DIAG_WINSERVER_LAG_BEGIN"
Write-Host "TIME"
Get-Date

Write-Host "OS_MEMORY"
Get-CimInstance Win32_OperatingSystem |
  Select-Object Caption,
    @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
    @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}},
    @{Name="UsedGB";Expression={[math]::Round(($_.TotalVisibleMemorySize-$_.FreePhysicalMemory)/1MB,2)}} |
  Format-Table -AutoSize

Write-Host "CPU_COUNTER_5S"
Get-Counter '\Processor(_Total)\% Processor Time' -SampleInterval 1 -MaxSamples 5 |
  Select-Object -ExpandProperty CounterSamples |
  Select-Object @{Name="CPU";Expression={[math]::Round($_.CookedValue,1)}} |
  Format-Table -AutoSize

Write-Host "TOP_CPU_PROCESS"
$p1 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet
Start-Sleep -Seconds 2
$p2 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet
$rows = foreach ($b in $p2) {
  $a = $p1 | Where-Object Id -eq $b.Id | Select-Object -First 1
  if ($a -and $b.CPU -ne $null -and $a.CPU -ne $null) {
    [pscustomobject]@{
      ProcessName = $b.ProcessName
      Id = $b.Id
      CpuPctApprox = [math]::Round((($b.CPU - $a.CPU) / 2) * 100 / [Environment]::ProcessorCount, 1)
      MB = [math]::Round($b.WorkingSet / 1MB, 1)
    }
  }
}
$rows | Sort-Object CpuPctApprox -Descending | Select-Object -First 15 | Format-Table -AutoSize

Write-Host "TOP_MEM_PROCESS"
Get-Process |
  Sort-Object WorkingSet -Descending |
  Select-Object -First 15 ProcessName,Id,@{Name="MB";Expression={[math]::Round($_.WorkingSet/1MB,1)}},CPU |
  Format-Table -AutoSize

Write-Host "VIDEO_CONTROLLER"
Get-CimInstance Win32_VideoController |
  Select-Object Name, VideoProcessor, AdapterRAM, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution |
  Format-Table -AutoSize

Write-Host "NETWORK"
Test-NetConnection 1.1.1.1 -InformationLevel Detailed |
  Select-Object ComputerName, RemoteAddress, PingSucceeded, PingReplyDetails |
  Format-List

Write-Host "LISTEN_PORTS"
Get-NetTCPConnection -State Listen -ErrorAction SilentlyContinue |
  Where-Object { $_.LocalPort -in 22,80,3306,2907 } |
  Select-Object LocalAddress,LocalPort,OwningProcess |
  Format-Table -AutoSize

Write-Host "DIAG_WINSERVER_LAG_DONE"
