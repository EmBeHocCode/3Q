from pathlib import Path
import shutil
import time
import zipfile

root = Path("/var/www/3q-vuonggia/3QVuongGia/www/update/R10")
src_zip = root / "zipsource/1.1.7/1.1.0-1.1.7.zip"
newdir = root / "zipsource/1.1.8"
newdir.mkdir(parents=True, exist_ok=True)
target = "lua/logic/login/LoginLayer.lua"

new_login = """function LoginLayer:loginWin()

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


def patch_login(data: bytes) -> bytes:
    s = data.decode("utf-8", errors="replace")
    start = s.index("function LoginLayer:loginWin()")
    end = s.index("function LoginLayer:playEffect()", start)
    return (s[:start] + new_login + s[end:]).encode("utf-8")


def make_zip(zip_name: str):
    out = newdir / zip_name
    tmp = newdir / (zip_name + ".tmp")
    if tmp.exists():
        tmp.unlink()
    with zipfile.ZipFile(src_zip, "r") as zin, zipfile.ZipFile(tmp, "w") as zout:
        for item in zin.infolist():
            data = b"" if item.is_dir() else zin.read(item.filename)
            if item.filename == target:
                data = patch_login(data)
            zout.writestr(item, data)
        zout.comment = zin.comment
    tmp.replace(out)
    with zipfile.ZipFile(out) as z:
        body = z.read(target).decode("utf-8", errors="replace")
        start = body.index("function LoginLayer:loginWin()")
        end = body.index("function LoginLayer:playEffect()", start)
        print(out.name, out.stat().st_size, "entries", len(z.infolist()), "first", z.infolist()[0].filename)
        print(body[start:end])


for name in ["1.1.0-1.1.8.zip", "1.1.7-1.1.8.zip", "1.1.4-1.1.8.zip"]:
    make_zip(name)

check = root / "check.xml"
shutil.copy2(check, root / f"check.xml.bak-to-118-{int(time.time())}")
check.write_text(
    '<?xml version="1.0" encoding="UTF-8" ?>\n'
    '<version current="1.1.8">\n'
    '    <c content="Cập nhật sửa đăng nhập sạch !" date="" />\n'
    '</version>\n',
    encoding="utf-8",
)
print("check.xml current=1.1.8")
