$ErrorActionPreference = "Continue"

$roots = @(
  "C:\xampp\htdocs\langla",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)"
)

$exts = @(".php",".html",".htm",".css",".js",".txt",".json",".xml")
$badPattern = '[\u00C3\u00C2\u00C4\u00C6\u00A1\u00BA\u00BB\uFFFD]'

function Get-BadScore([string]$s) {
  if ($null -eq $s) { return 0 }
  return ([regex]::Matches($s, $badPattern)).Count
}

function Repair-Text([string]$text) {
  $current = $text
  for ($i = 0; $i -lt 4; $i++) {
    $before = Get-BadScore $current
    $best = $current
    $bestScore = $before

    foreach ($encName in @("Windows-1252","iso-8859-1")) {
      try {
        $enc = [System.Text.Encoding]::GetEncoding($encName)
        $bytes = $enc.GetBytes($current)
        $candidate = [System.Text.Encoding]::UTF8.GetString($bytes)
        $score = Get-BadScore $candidate
        if ($score -lt $bestScore) {
          $best = $candidate
          $bestScore = $score
        }
      } catch {}
    }

    if ($best -eq $current) { break }
    $current = $best
  }
  return $current
}

$patched = 0
foreach ($root in $roots) {
  if (!(Test-Path -LiteralPath $root)) {
    Write-Host "MISSING_ROOT $root"
    continue
  }
  Get-ChildItem -LiteralPath $root -Recurse -File -ErrorAction SilentlyContinue | ForEach-Object {
    if ($exts -notcontains $_.Extension.ToLowerInvariant()) { return }
    $path = $_.FullName
    try {
      $bytes = [IO.File]::ReadAllBytes($path)
      if ([Array]::IndexOf($bytes, [byte]0) -ge 0) { return }
      $text = [System.Text.Encoding]::UTF8.GetString($bytes)
      $before = Get-BadScore $text
      if ($before -eq 0) { return }
      $fixed = Repair-Text $text
      $after = Get-BadScore $fixed
      if ($fixed -ne $text -and $after -lt $before) {
        [IO.File]::WriteAllText($path, $fixed, (New-Object System.Text.UTF8Encoding($false)))
        $patched++
        Write-Host "PATCHED $before->$after $path"
      }
    } catch {
      Write-Host "SKIP $path $($_.Exception.Message)"
    }
  }
}

Write-Host "TOTAL_PATCHED=$patched"

Write-Host "=== SMOKE ==="
foreach ($url in @(
  "http://127.0.0.1/langla/",
  "http://127.0.0.1/langla/login/",
  "http://127.0.0.1/langla/register/",
  "http://127.0.0.1/langla/bang-xep-hang/",
  "http://127.0.0.1/langla/tai-ve/"
)) {
  Write-Host "--- $url"
  try {
    $r = Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 8
    $score = Get-BadScore $r.Content
    $err = ($r.Content -match "Fatal error|Warning|Notice|Undefined")
    Write-Host "OK status=$($r.StatusCode) len=$($r.RawContentLength) bad_score=$score php_error=$err"
    if ($score -gt 0 -or $err) {
      ($r.Content -split "`n" | Select-String -Pattern "$badPattern|Fatal error|Warning|Notice|Undefined" | Select-Object -First 5) | ForEach-Object { $_.Line }
    }
  } catch {
    Write-Host "FAIL $($_.Exception.Message)"
  }
}
