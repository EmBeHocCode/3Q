$ErrorActionPreference = 'Continue'

$publicIp = '104.248.157.207'
$outer = 'C:\Users\Administrator\Desktop\3QVuongGia'
$root = 'D:\3QVuongGia'
$backupRoot = 'C:\3q-logs\config-backup'
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'

New-Item -ItemType Directory -Force -Path "$backupRoot\$stamp" | Out-Null

if (-not (Test-Path -LiteralPath $root)) {
  cmd /c "subst D: /D" 2>$null | Out-Null
  cmd /c "subst D: `"$outer`""
  Start-Sleep -Seconds 1
}

$targets = @(
  "$root\www\server\lis.do",
  "$root\www\server\lis.php",
  "$root\www\vip\api.php",
  "$root\www\update\R10\zipsource\1.1.4\LoginLayer.lua",
  "$root\www\update\R10\zipsource\1.1.4\1.1.0-1.1.4\lua\logic\login\LoginLayer.lua",
  "$root\www\update\R10\zipsource\1.1.4\1.1.3-1.1.4\lua\logic\login\LoginLayer.lua",
  "$root\data\usercenter_HD\config\info.properties"
)

foreach ($file in $targets) {
  if (-not (Test-Path -LiteralPath $file)) { continue }
  $rel = $file.Replace($root, '').TrimStart('\')
  $dest = Join-Path "$backupRoot\$stamp" ($rel -replace '[\\/:*?"<>|]', '_')
  Copy-Item -LiteralPath $file -Destination $dest -Force
  $text = Get-Content -LiteralPath $file -Raw -Encoding UTF8
  $text = $text.Replace('192.168.1.234', $publicIp)
  $text = $text.Replace('103.92.25.91', $publicIp)
  $text = $text.Replace('103.90.225.183', $publicIp)
  Set-Content -LiteralPath $file -Value $text -Encoding UTF8
  Write-Output "patched $file"
}

Write-Output "backup: $backupRoot\$stamp"
