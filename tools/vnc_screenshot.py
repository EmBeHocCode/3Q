import socket
import struct
import sys

from PIL import Image


def recvall(sock, size):
    data = b""
    while len(data) < size:
        chunk = sock.recv(min(65536, size - len(data)))
        if not chunk:
            raise EOFError("socket closed")
        data += chunk
    return data


host = "104.248.157.207"
port = 5901
out = r"C:\Users\PC\AppData\Local\Temp\win-vm-vnc.png"

s = socket.create_connection((host, port), timeout=10)
proto = recvall(s, 12)
print("proto", proto)
s.sendall(proto)

n = recvall(s, 1)[0]
types = recvall(s, n)
print("security_types", types)
if 1 not in types:
    raise SystemExit("VNC server does not allow None auth")
s.sendall(b"\x01")
print("security_result", recvall(s, 4))

s.sendall(b"\x01")
init = recvall(s, 24)
w, h = struct.unpack(">HH", init[:4])
pf = init[4:20]
name_len = struct.unpack(">I", init[20:24])[0]
name = recvall(s, name_len)
print("size", w, h, "name", name)

bpp, depth, bigend, truecolor = pf[:4]
redmax, greenmax, bluemax = struct.unpack(">HHH", pf[4:10])
rshift, gshift, bshift = pf[10:13]
print("pixfmt", bpp, depth, bigend, truecolor, redmax, greenmax, bluemax, rshift, gshift, bshift)

s.sendall(struct.pack(">BBH", 2, 0, 1) + struct.pack(">i", 0))
s.sendall(struct.pack(">BBHHHH", 3, 0, 0, 0, w, h))

msg = recvall(s, 4)
print("message", msg)
if msg[0] != 0:
    raise SystemExit("not a framebuffer update")

rects = struct.unpack(">H", msg[2:4])[0]
img = Image.new("RGB", (w, h))
for _ in range(rects):
    hdr = recvall(s, 12)
    x, y, rw, rh, enc = struct.unpack(">HHHHi", hdr)
    print("rect", x, y, rw, rh, enc)
    if enc != 0:
        raise SystemExit(f"unsupported encoding {enc}")

    step = bpp // 8
    raw = recvall(s, rw * rh * step)
    pixels = []
    endian = "big" if bigend else "little"
    for i in range(0, len(raw), step):
        val = int.from_bytes(raw[i : i + step], endian)
        r = ((val >> rshift) & redmax) * 255 // redmax
        g = ((val >> gshift) & greenmax) * 255 // greenmax
        b = ((val >> bshift) & bluemax) * 255 // bluemax
        pixels.append((r, g, b))
    sub = Image.new("RGB", (rw, rh))
    sub.putdata(pixels)
    img.paste(sub, (x, y))

img.save(out)
print(out)
