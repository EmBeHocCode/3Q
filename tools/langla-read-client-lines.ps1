$files = @(
  @{Path="C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\RLoadServer.java"; Start=1; End=180},
  @{Path="C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\LoginPCScreen.java"; Start=180; End=215}
)
foreach ($f in $files) {
  Write-Host "=== $($f.Path) ==="
  $lines = Get-Content -LiteralPath $f.Path
  for ($i=$f.Start; $i -le [Math]::Min($f.End, $lines.Count); $i++) {
    "{0,4}: {1}" -f $i,$lines[$i-1]
  }
}
