from pathlib import Path
import shutil
import time
import zipfile

base = Path("/var/www/3q-vuonggia/3QVuongGia/www/update/R10/zipsource/1.1.4")
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


def patched_bytes(orig_bytes: bytes) -> bytes:
    s = orig_bytes.decode("utf-8", errors="replace")
    start = s.index("function LoginLayer:loginWin()")
    end = s.index("function LoginLayer:playEffect()", start)
    return (s[:start] + new_login + s[end:]).encode("utf-8")


def rebuild_from_backup(zip_name: str):
    current = base / zip_name
    backups = sorted(base.glob(zip_name + ".bak-codex-final-*"), key=lambda p: p.stat().st_mtime)
    if not backups:
        backups = sorted(base.glob(zip_name + ".bak-codex-*"), key=lambda p: p.stat().st_mtime)
    if not backups:
        raise RuntimeError(f"No backup for {zip_name}")
    src = backups[0]
    out = base / (zip_name + ".tmp")
    bad_bak = base / (zip_name + ".bad-repacked-" + str(int(time.time())))
    shutil.copy2(current, bad_bak)
    with zipfile.ZipFile(src, "r") as zin, zipfile.ZipFile(out, "w") as zout:
        for item in zin.infolist():
            data = b"" if item.is_dir() else zin.read(item.filename)
            if item.filename == target:
                data = patched_bytes(data)
            zout.writestr(item, data)
        zout.comment = zin.comment
    out.replace(current)
    with zipfile.ZipFile(current) as z:
        body = z.read(target).decode("utf-8", errors="replace")
        start = body.index("function LoginLayer:loginWin()")
        end = body.index("function LoginLayer:playEffect()", start)
        print(zip_name, "src", src.name, "entries", len(z.infolist()), "size", current.stat().st_size)
        print(body[start:end])


for name in ["1.1.0-1.1.4.zip", "1.1.3-1.1.4.zip"]:
    rebuild_from_backup(name)
