$ErrorActionPreference = "Continue"

Write-Host "ENABLE_RDP_AUDIO_BEGIN"

Write-Host "ENABLE_AUDIO_SERVICES"
$services = @(
  "AudioEndpointBuilder",
  "Audiosrv"
)

foreach ($svcName in $services) {
  $svc = Get-Service -Name $svcName -ErrorAction SilentlyContinue
  if ($svc) {
    Set-Service -Name $svcName -StartupType Automatic -ErrorAction SilentlyContinue
    if ($svc.Status -ne "Running") {
      Start-Service -Name $svcName -ErrorAction SilentlyContinue
    }
  }
}

Write-Host "ENABLE_RDP_AUDIO_POLICY"
$tsPolicy = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
New-Item -Path $tsPolicy -Force | Out-Null
New-ItemProperty -Path $tsPolicy -Name "fDisableAudioPlayback" -PropertyType DWord -Value 0 -Force | Out-Null
New-ItemProperty -Path $tsPolicy -Name "fDisableAudioCapture" -PropertyType DWord -Value 0 -Force | Out-Null

$rdpTcp = "HKLM:\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp"
New-ItemProperty -Path $rdpTcp -Name "fDisableAudio" -PropertyType DWord -Value 0 -Force | Out-Null

Write-Host "RESTART_RDP_SERVICE_SOFT"
# Không restart TermService ở đây để khỏi đá phiên RDP hiện tại quá gắt.

Write-Host "AUDIO_SERVICES_STATUS"
Get-Service AudioEndpointBuilder, Audiosrv |
  Select-Object Name, Status, StartType |
  Format-Table -AutoSize

Write-Host "AUDIO_DEVICES"
Get-CimInstance Win32_SoundDevice -ErrorAction SilentlyContinue |
  Select-Object Name, Status, Manufacturer |
  Format-Table -AutoSize

Write-Host "ENABLE_RDP_AUDIO_DONE"
