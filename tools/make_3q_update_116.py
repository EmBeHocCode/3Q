from pathlib import Path
import shutil
import time
import zipfile

root = Path("/var/www/3q-vuonggia/3QVuongGia/www/update/R10")
src = root / "zipsource/1.1.5/1.1.4-1.1.5"
newbase = root / "zipsource/1.1.6"
inc = newbase / "1.1.5-1.1.6"
full = newbase / "1.1.0-1.1.6"

for d in (inc, full):
    if d.exists():
        shutil.rmtree(d)
    shutil.copytree(src, d)

new_login_win = """function LoginLayer:loginWin()

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

"""


def patch_file(d: Path) -> Path:
    p = d / "lua/logic/login/LoginLayer.lua"
    s = p.read_text(errors="replace")
    start = s.index("function LoginLayer:loginWin()")
    end = s.index("function LoginLayer:playEffect()", start)
    s = s[:start] + new_login_win + s[end:]
    p.write_text(s)
    return p


for d in (inc, full):
    print("patched", patch_file(d))

for name, d in (("1.1.5-1.1.6.zip", inc), ("1.1.0-1.1.6.zip", full)):
    zp = newbase / name
    if zp.exists():
        zp.unlink()
    with zipfile.ZipFile(zp, "w", zipfile.ZIP_DEFLATED) as z:
        for f in d.rglob("*"):
            if f.is_file():
                z.write(f, f.relative_to(d).as_posix())
    print(zp, zp.stat().st_size)

check = root / "check.xml"
backup = root / f"check.xml.bak-bypass-{int(time.time())}"
shutil.copy2(check, backup)
check.write_text(
    '<?xml version="1.0" encoding="UTF-8" ?>\n'
    '<version current="1.1.6">\n'
    '    <c content="Cập nhật sửa đăng nhập lần 2 !" date="" />\n'
    '</version>\n',
    encoding="utf-8",
)
print("backup", backup)
