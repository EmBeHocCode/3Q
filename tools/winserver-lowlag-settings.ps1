$ErrorActionPreference = "Continue"

Write-Host "LOWLAG_SETTINGS_BEGIN"

Write-Host "POWER_HIGH_PERFORMANCE"
powercfg /setactive SCHEME_MIN
powercfg /change monitor-timeout-ac 0
powercfg /change standby-timeout-ac 0
powercfg /change hibernate-timeout-ac 0

Write-Host "DISABLE_VISUAL_EFFECTS"
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f
reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012038010000000 /f
reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAnimations /t REG_DWORD /d 0 /f

Write-Host "DISABLE_UNUSED_SERVICES"
$services = @(
  "WSearch",
  "SysMain",
  "wuauserv",
  "BITS",
  "edgeupdate",
  "edgeupdatem"
)

foreach ($svcName in $services) {
  $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
  if ($svc) {
    Write-Host ("Stopping/disabling {0}" -f $svcName)
    Stop-Service -Name $svcName -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svcName -StartupType Disabled -ErrorAction SilentlyContinue
  }
}

Write-Host "DISABLE_STARTUP_JAVA_UPDATER"
reg delete "HKLM\Software\Microsoft\Windows\CurrentVersion\Run" /v SunJavaUpdateSched /f
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /v SunJavaUpdateSched /f

Write-Host "ADD_GAME_DEFENDER_EXCLUSION"
if (Get-Command Add-MpPreference -ErrorAction SilentlyContinue) {
  Add-MpPreference -ExclusionPath "C:\LangLa" -ErrorAction SilentlyContinue
}

Write-Host "CURRENT_TOP"
Get-Process |
  Sort-Object WorkingSet -Descending |
  Select-Object -First 10 ProcessName,Id,@{Name="MB";Expression={[math]::Round($_.WorkingSet/1MB,1)}},CPU |
  Format-Table -AutoSize

Write-Host "LOWLAG_SETTINGS_DONE"
