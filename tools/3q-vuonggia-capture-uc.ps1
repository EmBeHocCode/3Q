$ErrorActionPreference = "Continue"
cmd /c "subst D: C:\Users\Administrator\Downloads\3QVuongGia 2>nul"
$root = "D:\3QVuongGia"
$uc = "$root\data\usercenter_HD"
$log = "C:\Users\Administrator\Desktop\uc-capture.log"
Set-Location $uc
Write-Host "PWD=$PWD"
Write-Host "Writing $log"
cmd /c "D:\3QVuongGia\Java\jdk1.8.0_121\bin\java -Xmx1024m -Xms512m -Xss256k -XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=./oom.hprof -XX:+UnlockExperimentalVMOptions -XX:+UseG1GC -XX:MaxGCPauseMillis=50 -XX:GCPauseIntervalMillis=200 -XX:SurvivorRatio=6 -Xloggc:logs/gc.log -classpath ""./;./lib/*;./config"" com.playmore.http.jetty.SpringContextLoader > ""$log"" 2>&1"
Write-Host "EXIT=$LASTEXITCODE"
Get-Content $log -Tail 120
