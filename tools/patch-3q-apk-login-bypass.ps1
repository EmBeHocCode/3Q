$ErrorActionPreference = "Stop"

$apk = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong.apk"
$out = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong_104.248.157.207_loginfix.apk"
$work = "E:\SourceGame add\3QVuongGia\3QVuongGia\app\apk_patch_loginfix"
$unsigned = Join-Path $work "patched-unsigned.apk"
$keystore = Join-Path $work "debug-3q.keystore"
$py = Join-Path $work "patch_zip_loginfix.py"
$ip = "104.248.157.207"

Remove-Item -LiteralPath $work -Recurse -Force -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Force -Path $work | Out-Null
Remove-Item -LiteralPath $out -Force -ErrorAction SilentlyContinue

Set-Content -LiteralPath $py -Encoding UTF8 -Value @'
import re
import sys
import zipfile

src, dst, ip = sys.argv[1], sys.argv[2], sys.argv[3]

old_re = re.compile(rb"192\.168\.1\.234|103\.92\.25\.91|103\.90\.225\.183|103\.67\.198\.195")
logic_login = "assets/lua/logic/login/LoginLayer.lua"

new_login = '''function LoginLayer:loginWin()

\tlocal self = LoginLayer 
\tlocal userName = LoginLayer.input_name:getText()
\tlocal password = LoginLayer.input_pwd:getText()
\tif string.len(userName) < 6 then
\t\ttoastMessage("Tài khoản >= 6 kí tự")
\t\treturn
\tend
\tif string.len(password) < 6 then
\t\ttoastMessage("Mật khẩu >= 6 kí tự")
\t\treturn
\tend
\tprint("[3QCodex] offline login bypass for private server")
\tTFPlugins.setUserID(userName)
\tself.loginStatus = LoginLayer.LOGIN_SUC
\tLoginLayer:enterNextPage()
end

'''

report = []
with zipfile.ZipFile(src, "r") as zin, zipfile.ZipFile(dst, "w") as zout:
    for info in zin.infolist():
        if info.filename.startswith("META-INF/"):
            continue
        data = zin.read(info.filename)
        changed = False
        if info.filename.endswith(".lua"):
            hits = len(old_re.findall(data))
            if hits:
                data = old_re.sub(ip.encode("ascii"), data)
                changed = True
                report.append(f"{info.filename} ip_hits={hits}")
        if info.filename == logic_login:
            s = data.decode("utf-8", errors="replace")
            start = s.index("function LoginLayer:loginWin()")
            end = s.index("function LoginLayer:playEffect()", start)
            s = s[:start] + new_login + s[end:]
            data = s.encode("utf-8")
            changed = True
            report.append(f"{info.filename} loginWin=bypass")
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
Get-Content -LiteralPath (Join-Path $work "patch-report.txt")
Get-Item -LiteralPath $out | Select-Object FullName,Length,LastWriteTime | Format-List
