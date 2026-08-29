$ErrorActionPreference = "Continue"

Write-Host "WINSERVER_LAG_NOW_BEGIN"
Get-Date

Write-Host "CPU_SAMPLE"
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

Write-Host "MEM"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

Write-Host "JAVA_QEMU_RELATED"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match 'java|python|roblox|steam|chrome|edge|game|launcher' } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "WINSERVER_LAG_NOW_DONE"
