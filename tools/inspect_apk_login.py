import zipfile

apk = r"E:\SourceGame add\3QVuongGia\3QVuongGia\app\3qdevuong.apk"
patterns = [b"login.php", b"103.67.198.195", b"192.168.1.234", b"function LoginLayer", b"loginWin"]

with zipfile.ZipFile(apk) as z:
    for n in z.namelist():
        if "LoginLayer.lua" in n or (n.endswith(".lua") and any(p in z.read(n) for p in patterns)):
            data = z.read(n)
            hits = [(p.decode("ascii", errors="ignore"), data.find(p)) for p in patterns if data.find(p) >= 0]
            print(n, z.getinfo(n).file_size, hits)
            txt = data.decode("utf-8", errors="ignore")
            for marker in ["function LoginLayer", "loginWin", "login.php", "192.168.1.234", "103.67.198.195"]:
                idx = txt.find(marker)
                if idx >= 0:
                    print("MARKER", marker, idx)
                    print(txt[max(0, idx - 250): idx + 500])
                    break
