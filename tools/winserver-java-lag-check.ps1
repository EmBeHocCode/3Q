$ErrorActionPreference = "Continue"

Write-Host "WINSERVER_JAVA_LAG_CHECK_BEGIN"
Get-Date

Write-Host "CPU_SAMPLE_5S"
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
$rows | Sort-Object CpuPct -Descending | Select-Object -First 25 | Format-Table -AutoSize

Write-Host "TOP_MEM"
Get-Process |
  Sort-Object WorkingSet -Descending |
  Select-Object -First 20 ProcessName,Id,@{Name="MB";Expression={[math]::Round($_.WorkingSet/1MB,1)}},CPU |
  Format-Table -AutoSize

Write-Host "JAVA_UPDATE_RELATED"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match 'java|javaw|msiexec|jusched|update|launcher|game|steam|chrome|edge' -or $_.CommandLine -match 'Java|Lang|Launcher|Update' } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "SERVICES_MATCH"
Get-CimInstance Win32_Service |
  Where-Object { $_.Name -match 'Java|Update|Lang|Mongo' -or $_.PathName -match 'java|Lang|Mongo' } |
  Select-Object Name,DisplayName,State,StartMode,ProcessId,PathName |
  Format-List

Write-Host "MEM"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

Write-Host "WINSERVER_JAVA_LAG_CHECK_DONE"
