$ErrorActionPreference = "Continue"
$server = "C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server"
$logDir = "C:\Users\Administrator\Desktop\_3Q_Codex_Tools_Logs"

Write-Host "=== TIME ==="
Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Host "=== LANGLA FILE LOG FULL ==="
$lf = Join-Path $server "langla.log"
if (Test-Path $lf) { Get-Content -LiteralPath $lf -Tail 260 } else { Write-Host "MISSING $lf" }

Write-Host "=== MAIN JAVA IMPORTANT LINES ==="
$main = Join-Path $server "src\main\java\com\sg188\server\Main.java"
if (Test-Path $main) {
  $lines = Get-Content -LiteralPath $main
  foreach ($range in @(@(1,90),@(150,230))) {
    for ($i=$range[0]; $i -le [Math]::Min($range[1], $lines.Count); $i++) {
      "{0,4}: {1}" -f $i,$lines[$i-1]
    }
  }
}

Write-Host "=== CONFIG / MONGO REFERENCES ==="
cmd /c "cd /d C:\Users\Administrator\Downloads\LanglaSrc\LanglaSrc\server\server\src && findstr /S /I /N /C:""mongo"" /C:""mongodb"" /C:""System.exit"" /C:""startServerSocket"" /C:""openServerSocket"" *.java"

Write-Host "=== JAVA VERSIONS ==="
cmd /c """C:\Program Files\Common Files\Oracle\Java\javapath\java.exe"" -version"
cmd /c """C:\Program Files (x86)\Common Files\Oracle\Java\java8path\java.exe"" -version"

Write-Host "=== RUN WITH JAVA8 FOREGROUND 20S ==="
$java8 = "C:\Program Files (x86)\Common Files\Oracle\Java\java8path\java.exe"
if (Test-Path $java8) {
  $out = Join-Path $logDir "langla-java8-test.out.log"
  $err = Join-Path $logDir "langla-java8-test.err.log"
  Remove-Item $out,$err -Force -ErrorAction SilentlyContinue
  $p = Start-Process -FilePath $java8 -ArgumentList "-server -jar -Dfile.encoding=UTF-8 `"out/artifacts/LangLaZ_jar/LangLaZ.jar`"" -WorkingDirectory $server -RedirectStandardOutput $out -RedirectStandardError $err -PassThru -WindowStyle Hidden
  Write-Host "PID=$($p.Id)"
  Start-Sleep -Seconds 20
  $alive = Get-Process -Id $p.Id -ErrorAction SilentlyContinue
  if ($alive) { Write-Host "JAVA8 STILL RUNNING"; Stop-Process -Id $p.Id -Force } else { Write-Host "JAVA8 EXITED" }
  Write-Host "--- OUT ---"
  if (Test-Path $out) { Get-Content $out -Tail 160 }
  Write-Host "--- ERR ---"
  if (Test-Path $err) { Get-Content $err -Tail 160 }
} else {
  Write-Host "JAVA8 missing: $java8"
}
