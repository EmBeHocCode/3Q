$ErrorActionPreference = "Continue"

Write-Host "=== HTTP CONTENT ==="
foreach ($url in @("http://127.0.0.1/serverlist.txt","http://127.0.0.1:80/serverlist.txt","http://127.0.0.1:82/serverlist.txt")) {
  Write-Host "--- $url"
  try { (Invoke-WebRequest -UseBasicParsing $url -TimeoutSec 5).Content } catch { "FAIL: " + $_.Exception.Message }
}

Write-Host "=== APACHE/XAMPP PROCESSES ==="
Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "httpd|apache|xampp|nginx|php" } |
  Select-Object ProcessId,Name,CommandLine |
  Format-List

Write-Host "=== LISTEN PORTS ==="
netstat -ano | Select-String "LISTENING" | Select-String ":80|:82|:8080|:2907"

Write-Host "=== APACHE CONFIG DOCROOT/LISTEN ==="
$confCandidates = @(
  "C:\xampp\apache\conf\httpd.conf",
  "C:\xampp\apache\conf\extra\httpd-vhosts.conf",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\xampp\apache\conf\httpd.conf",
  "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\www (2)\apache\conf\httpd.conf"
)
foreach ($c in $confCandidates) {
  Write-Host "--- $c"
  if (Test-Path -LiteralPath $c) {
    Select-String -LiteralPath $c -Pattern "Listen|DocumentRoot|ServerRoot|htdocs|www" |
      Select-Object LineNumber,Line |
      Format-Table -AutoSize
  } else {
    "MISSING"
  }
}

Write-Host "=== FIND serverlist.txt ==="
$roots = @("C:\", "C:\Users\Administrator\Downloads")
foreach ($r in $roots) {
  Write-Host "--- root $r"
  Get-ChildItem -LiteralPath $r -Recurse -Filter "serverlist.txt" -File -ErrorAction SilentlyContinue |
    ForEach-Object {
      Write-Host "FILE:" $_.FullName
      Get-Content -LiteralPath $_.FullName -Raw
    }
}
