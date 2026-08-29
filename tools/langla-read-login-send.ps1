$paths = @(
  "C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\RSendTypeClient.java",
  "C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\LangLa_kz.java"
)
foreach ($p in $paths) {
  Write-Host "=== $p ==="
  Get-Content -LiteralPath $p -TotalCount 160
}
$p = "C:\Users\PC\Downloads\LanglaSrc\Client_LangLaLau\src\beatdz\LoginPCScreen.java"
Write-Host "=== $p 530-590 ==="
$lines = Get-Content -LiteralPath $p
for ($i=530; $i -le 590; $i++) { "{0,4}: {1}" -f $i,$lines[$i-1] }
