$ErrorActionPreference = "Continue"

$logs = @(
  "C:\Users\Administrator\Desktop\cross-capture.log",
  "C:\Users\Administrator\Desktop\s1-capture.log",
  "C:\Users\Administrator\Desktop\3q-cross.log",
  "C:\Users\Administrator\Desktop\3q-s1.log",
  "C:\Users\Administrator\Desktop\uc-run.log",
  "C:\Users\Administrator\Desktop\cross-run.log",
  "C:\Users\Administrator\Desktop\s1-run.log",
  "D:\3QVuongGia\data\cross_android\logs\*.log",
  "D:\3QVuongGia\data\server_4001\logs\*.log"
)

cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"

foreach ($pattern in $logs) {
  Get-ChildItem -Path $pattern -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 3 | ForEach-Object {
    Write-Host "=== LOG $($_.FullName) ==="
    Select-String -Path $_.FullName -Pattern "Exception|ERROR|Error|Caused by|Address already|Bind|refused|denied|failed|Failed" -SimpleMatch:$false -ErrorAction SilentlyContinue | Select-Object -Last 40 | ForEach-Object {
      Write-Host $_.Line
    }
    Write-Host "---TAIL---"
    Get-Content $_.FullName -Tail 80 -ErrorAction SilentlyContinue
  }
}
