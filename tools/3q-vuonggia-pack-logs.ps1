$ErrorActionPreference = "Continue"

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul" | Out-Null

$outDir = "C:\Users\Administrator\Desktop\3q-debug-pack"
$zip = "C:\Users\Administrator\Desktop\3q-debug-pack.zip"
Remove-Item -LiteralPath $outDir -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $outDir | Out-Null

$files = @(
  "D:\3QVuongGia\data\usercenter_HD\start.bat",
  "D:\3QVuongGia\data\cross_android\start.bat",
  "D:\3QVuongGia\data\server_4001\start.bat",
  "D:\3QVuongGia\1 - GM.bat",
  "D:\3QVuongGia\99.Web.lnk",
  "D:\3QVuongGia\0 - phpStudy.lnk"
)

foreach ($f in $files) {
  if (Test-Path -LiteralPath $f) {
    Copy-Item -LiteralPath $f -Destination (Join-Path $outDir ((Split-Path $f -Leaf) -replace '[\\/:*?"<>|]','_')) -Force
  }
}

if (Test-Path "C:\3q-logs") {
  Copy-Item -LiteralPath "C:\3q-logs" -Destination (Join-Path $outDir "3q-logs") -Recurse -Force
}

foreach ($d in @(
  "D:\3QVuongGia\data\usercenter_HD\logs",
  "D:\3QVuongGia\data\cross_android\logs",
  "D:\3QVuongGia\data\server_4001\logs",
  "D:\3QVuongGia\apache-tomcat-7.0.90\logs",
  "D:\3QVuongGia\apache-tomcat-8.5.40\logs",
  "D:\3QVuongGia\phpStudy\Apache\logs"
)) {
  if (Test-Path -LiteralPath $d) {
    $name = ($d -replace '[:\\]+','_').Trim('_')
    Copy-Item -LiteralPath $d -Destination (Join-Path $outDir $name) -Recurse -Force
  }
}

Get-CimInstance Win32_Process |
  Where-Object { $_.Name -match "java|cmd|conhost|mysqld|httpd|phpStudy" } |
  Select-Object Name,ProcessId,CommandLine |
  Format-List |
  Out-File -Encoding UTF8 (Join-Path $outDir "processes.txt")

netstat -ano > (Join-Path $outDir "netstat.txt")
cmd /c subst > (Join-Path $outDir "subst.txt")

Compress-Archive -LiteralPath (Join-Path $outDir "*") -DestinationPath $zip -Force
Write-Host "PACKED $zip"
