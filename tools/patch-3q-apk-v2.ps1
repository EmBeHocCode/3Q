$ErrorActionPreference = "Stop"

$apk = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong.apk"
$out = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong_104.248.157.207.apk"
$work = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\apk_patch_work_v2"
$unsigned = Join-Path $work "patched-unsigned.apk"
$keystore = Join-Path $work "debug-3q.keystore"
$py = Join-Path $work "patch_zip.py"
$ip = "104.248.157.207"

Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $work | Out-Null
Remove-Item -LiteralPath $out -Force -ErrorAction SilentlyContinue

Set-Content -LiteralPath $py -Encoding UTF8 -Value @'
import re, sys, zipfile

src, dst, ip = sys.argv[1], sys.argv[2], sys.argv[3]
targets = {
    "assets/TFFramework/Plugins/TFPlugins.lua",
    "assets/lua/logic/login/LoginLayer.lua",
    "assets/lua/uiconfig_mango_new/login/LoginLayer.lua",
}
old_re = re.compile(rb"192\.168\.1\.234|103\.92\.25\.91|103\.90\.225\.183")
report = []

with zipfile.ZipFile(src, "r") as zin, zipfile.ZipFile(dst, "w") as zout:
    for info in zin.infolist():
        if info.filename.startswith("META-INF/"):
            continue
        data = zin.read(info.filename)
        if info.filename in targets:
            hits = len(old_re.findall(data))
            data = old_re.sub(ip.encode("ascii"), data)
            new_hits = data.count(ip.encode("ascii"))
            report.append(f"{info.filename} old_hits={hits} new_ip_hits={new_hits}")
        zi = zipfile.ZipInfo(info.filename, date_time=info.date_time)
        zi.comment = info.comment
        zi.extra = info.extra
        zi.internal_attr = info.internal_attr
        zi.external_attr = info.external_attr
        zi.create_system = info.create_system
        zi.compress_type = info.compress_type
        zout.writestr(zi, data)

for line in report:
    print(line)
'@

python $py $apk $unsigned $ip | Tee-Object -FilePath (Join-Path $work "patch-report.txt")

$keytoolLog = Join-Path $work "keytool.log"
$jarsignerLog = Join-Path $work "jarsigner.log"
$verifyLog = Join-Path $work "verify.log"

cmd /c "keytool -genkeypair -v -noprompt -keystore `"$keystore`" -storepass android -keypass android -alias androiddebugkey -keyalg RSA -keysize 2048 -validity 10000 -dname `"CN=Android Debug,O=Android,C=US`" > `"$keytoolLog`" 2>&1"
if ($LASTEXITCODE -ne 0) { Get-Content -LiteralPath $keytoolLog -ErrorAction SilentlyContinue; throw "keytool failed $LASTEXITCODE" }

cmd /c "jarsigner -keystore `"$keystore`" -storepass android -keypass android -signedjar `"$out`" `"$unsigned`" androiddebugkey > `"$jarsignerLog`" 2>&1"
if ($LASTEXITCODE -ne 0) { Get-Content -LiteralPath $jarsignerLog -ErrorAction SilentlyContinue; throw "jarsigner failed $LASTEXITCODE" }

cmd /c "jarsigner -verify -verbose -certs `"$out`" > `"$verifyLog`" 2>&1"

Write-Host "OUT=$out"
Get-Item -LiteralPath $out | Select-Object FullName,Length,LastWriteTime | Format-List
Write-Host "=== VERIFY TAIL ==="
Get-Content -LiteralPath (Join-Path $work "verify.log") -Tail 20
