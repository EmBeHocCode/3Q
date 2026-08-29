$ErrorActionPreference = "Continue"

Write-Host "TRIM_FOR_AFK_GAME_BEGIN"
Write-Host "KEEP: javaw.exe game client, RDP, SSH"

Write-Host "MEM_BEFORE"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

$stopByCommandLine = @(
  "LangLaZ.jar"
)

foreach ($needle in $stopByCommandLine) {
  Get-CimInstance Win32_Process |
    Where-Object { $_.CommandLine -like "*$needle*" } |
    ForEach-Object {
      Write-Host ("Stopping by cmdline PID={0} Name={1} Match={2}" -f $_.ProcessId, $_.Name, $needle)
      Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
    }
}

$processesToStop = @(
  "mongod",
  "jusched",
  "MicrosoftEdgeUpdate",
  "SearchApp",
  "RuntimeBroker",
  "ApplicationFrameHost",
  "Game Launcher"
)

foreach ($procName in $processesToStop) {
  Get-Process -Name $procName -ErrorAction SilentlyContinue |
    ForEach-Object {
      Write-Host ("Stopping process {0} PID={1}" -f $_.ProcessName, $_.Id)
      Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
    }
}

$servicesToStop = @(
  "MongoDB",
  "WSearch",
  "SysMain",
  "wuauserv",
  "BITS",
  "edgeupdate",
  "edgeupdatem"
)

foreach ($svcName in $servicesToStop) {
  $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
  if ($svc -and $svc.Status -eq "Running") {
    Write-Host ("Stopping service {0}" -f $svcName)
    Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
  }
}

Start-Sleep -Seconds 3

Write-Host "TOP_CPU_AFTER_3S"
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
$rows | Sort-Object CpuPct -Descending | Select-Object -First 15 | Format-Table -AutoSize

Write-Host "MEM_AFTER"
Get-CimInstance Win32_OperatingSystem |
  Select-Object @{Name="TotalGB";Expression={[math]::Round($_.TotalVisibleMemorySize/1MB,2)}},
                @{Name="FreeGB";Expression={[math]::Round($_.FreePhysicalMemory/1MB,2)}} |
  Format-Table -AutoSize

Write-Host "JAVA_LEFT"
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match '^java' } |
  Select-Object ProcessId, Name, CommandLine |
  Format-List

Write-Host "TRIM_FOR_AFK_GAME_DONE"
