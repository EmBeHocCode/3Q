$ErrorActionPreference = "Continue"

$desktop = [Environment]::GetFolderPath("Desktop")
$archive = Join-Path $desktop "_3Q_Codex_Tools_Logs"
New-Item -ItemType Directory -Force -Path $archive | Out-Null

$patterns = @(
  "3q-*.log",
  "3q-*.txt",
  "3q-*.ps1",
  "3q-*.cmd",
  "3q-*.sql",
  "3q-vuonggia-*.ps1",
  "3q-vuonggia-*.txt",
  "3q-vuonggia-*.zip",
  "cross-*.log",
  "cross-*.cmd",
  "uc-*.log",
  "uc-*.cmd",
  "s1-*.log",
  "s1-*.cmd",
  "fix-ucdb*.sql",
  "codex-test*",
  "run-3q*.cmd"
)

$moved = @()
foreach ($pattern in $patterns) {
  Get-ChildItem -LiteralPath $desktop -File -Filter $pattern -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -ne $PSCommandPath } |
    ForEach-Object {
      $dest = Join-Path $archive $_.Name
      if (Test-Path -LiteralPath $dest) {
        $base = [IO.Path]::GetFileNameWithoutExtension($_.Name)
        $ext = [IO.Path]::GetExtension($_.Name)
        $dest = Join-Path $archive ("{0}-{1}{2}" -f $base, (Get-Date -Format "yyyyMMdd-HHmmss"), $ext)
      }
      Move-Item -LiteralPath $_.FullName -Destination $dest -Force
      $moved += $_.Name
    }
}

foreach ($dirName in @("3q-debug-pack")) {
  $dir = Join-Path $desktop $dirName
  if (Test-Path -LiteralPath $dir) {
    $dest = Join-Path $archive $dirName
    if (Test-Path -LiteralPath $dest) {
      $dest = Join-Path $archive ("{0}-{1}" -f $dirName, (Get-Date -Format "yyyyMMdd-HHmmss"))
    }
    Move-Item -LiteralPath $dir -Destination $dest -Force
    $moved += $dirName
  }
}

$status = @"
3Q desktop cleaned at $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

Moved files: $($moved.Count)
Archive: $archive

Useful commands:
- Check server: powershell -ExecutionPolicy Bypass -File C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs\3q-vuonggia-status-final.ps1
- Server auto-start task: 3QVuongGiaServer
- Runtime start script: C:\3q-run\3q-vuonggia-service-start.ps1
- Runtime logs: C:\3q-logs
"@

Set-Content -LiteralPath (Join-Path $archive "README.txt") -Encoding UTF8 -Value $status

Write-Host "MOVED=$($moved.Count)"
Write-Host "ARCHIVE=$archive"
Get-ChildItem -LiteralPath $desktop |
  Select-Object Name,Mode,Length,LastWriteTime |
  Format-Table -AutoSize
