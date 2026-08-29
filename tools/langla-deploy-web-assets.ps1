$ErrorActionPreference = "Continue"
$src = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
$dst = "C:\xampp\htdocs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== BACKUP XAMPP HTDOCS INDEX ==="
if (Test-Path "$dst\index.php") {
  Copy-Item "$dst\index.php" "$dst\index-xampp-backup.php" -Force
}

Write-Host "=== COPY WEB ASSETS ==="
robocopy "$src" "$dst" /E /NFL /NDL /NJH /NJS /NP
Write-Host "ROBOCOPY_EXIT=$LASTEXITCODE"

Write-Host "=== PATCH SERVERLIST ==="
Set-Content -Encoding ASCII -LiteralPath "$dst\serverlist.txt" -Value "LangLa,0,0,104.248.157.207,2907,2907"

Write-Host "=== PATCH CHECKPC IF EXISTS ==="
if (Test-Path "$dst\checkpc.txt") {
  Get-Content "$dst\checkpc.txt" -TotalCount 20
}

Write-Host "=== VERIFY URL LOCAL ==="
Get-Content "$dst\serverlist.txt"
Get-ChildItem "$dst\img" -Recurse -File -Include *.zip | Select-Object -First 10 FullName,Length | Format-Table -AutoSize
