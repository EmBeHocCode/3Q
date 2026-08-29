$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null
$root = "D:\3QVuongGia"
$out = "C:\Users\Administrator\Desktop\3q-read-bats.txt"
Remove-Item -LiteralPath $out -Force -ErrorAction SilentlyContinue

foreach ($p in @(
  "$root\data\usercenter_HD\start.bat",
  "$root\data\cross_android\start.bat",
  "$root\data\server_4001\start.bat",
  "$root\1 - GM.bat",
  "$root\99.Web.lnk",
  "$root\0 - phpStudy.lnk"
)) {
  Add-Content -LiteralPath $out -Encoding UTF8 -Value "=== $p ==="
  Add-Content -LiteralPath $out -Encoding UTF8 -Value "exists=$(Test-Path -LiteralPath $p)"
  if (Test-Path -LiteralPath $p) {
    if ($p -like "*.bat") {
      Add-Content -LiteralPath $out -Encoding UTF8 -Value ([System.IO.File]::ReadAllText($p, [Text.Encoding]::Default))
    } else {
      Add-Content -LiteralPath $out -Encoding UTF8 -Value "shortcut file"
    }
  }
}

Write-Host $out
