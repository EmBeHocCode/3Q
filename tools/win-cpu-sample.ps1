$ErrorActionPreference = "Continue"

Write-Host "WIN_CPU_SAMPLE_BEGIN"
$p1 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet
Start-Sleep -Seconds 3
$p2 = Get-Process | Select-Object Id, ProcessName, CPU, WorkingSet

$rows = foreach ($b in $p2) {
    $a = $p1 | Where-Object { $_.Id -eq $b.Id } | Select-Object -First 1
    if ($a -and $null -ne $b.CPU -and $null -ne $a.CPU) {
        [pscustomobject]@{
            Name = $b.ProcessName
            Id = $b.Id
            CpuPct = [math]::Round((($b.CPU - $a.CPU) / 3) * 100 / [Environment]::ProcessorCount, 1)
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

Write-Host "WIN_CPU_SAMPLE_DONE"
