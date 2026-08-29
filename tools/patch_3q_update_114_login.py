from pathlib import Path
import shutil
import time
import zipfile

root = Path("/var/www/3q-vuonggia/3QVuongGia/www/update/R10")
base = root / "zipsource/1.1.4"
targets = [
    base / "1.1.0-1.1.4",
    base / "1.1.3-1.1.4",
]

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

def patch_login_layer(folder: Path):
    p = folder / "lua/logic/login/LoginLayer.lua"
    bak = folder / f"lua/logic/login/LoginLayer.lua.bak-codex-{int(time.time())}"
    shutil.copy2(p, bak)
    s = p.read_text(errors="replace")
    start = s.index("function LoginLayer:loginWin()")
    end = s.index("function LoginLayer:playEffect()", start)
    s = s[:start] + new_login_win + s[end:]
    p.write_text(s)
    print("patched", p)

def zip_folder(folder: Path, zip_path: Path):
    backup = zip_path.with_suffix(zip_path.suffix + f".bak-codex-{int(time.time())}")
    if zip_path.exists():
        shutil.copy2(zip_path, backup)
        print("backup", backup)
    tmp = zip_path.with_suffix(".zip.tmp")
    if tmp.exists():
        tmp.unlink()
    with zipfile.ZipFile(tmp, "w", zipfile.ZIP_DEFLATED) as z:
        for f in folder.rglob("*"):
            if f.is_file() and ".bak-codex-" not in f.name:
                z.write(f, f.relative_to(folder).as_posix())
    tmp.replace(zip_path)
    print("zip", zip_path, zip_path.stat().st_size)

for folder in targets:
    patch_login_layer(folder)
    zip_folder(folder, folder.with_suffix(".zip"))

check = root / "check.xml"
shutil.copy2(check, root / f"check.xml.bak-back-to-114-{int(time.time())}")
check.write_text(
    '<?xml version="1.0" encoding="UTF-8" ?>\n'
    '<version current="1.1.4">\n'
    '    <c content="Cập nhật bản ổn định sửa đăng nhập !" date="" />\n'
    '</version>\n',
    encoding="utf-8",
)
print("check.xml set current=1.1.4")
