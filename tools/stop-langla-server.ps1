$ErrorActionPreference = "Continue"

Write-Host "STOP_LANG_LA_BEGIN"

$listeners = Get-NetTCPConnection -LocalPort 2907 -State Listen -ErrorAction SilentlyContinue
if ($listeners) {
    foreach ($listener in $listeners) {
        $pidToStop = $listener.OwningProcess
        try {
            $proc = Get-Process -Id $pidToStop -ErrorAction Stop
            Write-Host ("Stopping PID={0} Name={1}" -f $proc.Id, $proc.ProcessName)
            Stop-Process -Id $pidToStop -Force -ErrorAction Stop
        } catch {
            Write-Host ("Stop failed PID={0}: {1}" -f $pidToStop, $_.Exception.Message)
        }
    }
} else {
    Write-Host "No listener on 2907"
}

Start-Sleep -Seconds 2

$after = Get-NetTCPConnection -LocalPort 2907 -State Listen -ErrorAction SilentlyContinue
if ($after) {
    Write-Host "PORT_2907_STILL_LISTENING"
    $after | Format-Table -AutoSize
    exit 1
}

Write-Host "OK_PORT_2907_CLOSED"

$javaLeft = Get-Process java -ErrorAction SilentlyContinue
if ($javaLeft) {
    Write-Host "JAVA_LEFT:"
    $javaLeft | Select-Object Id, ProcessName, CPU, WorkingSet | Format-Table -AutoSize
} else {
    Write-Host "OK_NO_JAVA_PROCESS"
}

Write-Host "STOP_LANG_LA_DONE"
