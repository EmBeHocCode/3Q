import socket
import struct


def recvall(sock, size):
    data = b""
    while len(data) < size:
        chunk = sock.recv(min(65536, size - len(data)))
        if not chunk:
            raise EOFError("socket closed")
        data += chunk
    return data


host = "127.0.0.1"
port = 5901
out = "/tmp/win-vm-vnc.ppm"

s = socket.create_connection((host, port), timeout=10)
proto = recvall(s, 12)
s.sendall(proto)
n = recvall(s, 1)[0]
types = recvall(s, n)
if 1 not in types:
    raise SystemExit("VNC server does not allow None auth")
s.sendall(b"\x01")
recvall(s, 4)
s.sendall(b"\x01")

init = recvall(s, 24)
w, h = struct.unpack(">HH", init[:4])
pf = init[4:20]
name_len = struct.unpack(">I", init[20:24])[0]
recvall(s, name_len)

bpp, depth, bigend, truecolor = pf[:4]
redmax, greenmax, bluemax = struct.unpack(">HHH", pf[4:10])
rshift, gshift, bshift = pf[10:13]

s.sendall(struct.pack(">BBH", 2, 0, 1) + struct.pack(">i", 0))
s.sendall(struct.pack(">BBHHHH", 3, 0, 0, 0, w, h))

msg = recvall(s, 4)
if msg[0] != 0:
    raise SystemExit("not a framebuffer update")

rgb = bytearray(w * h * 3)
rects = struct.unpack(">H", msg[2:4])[0]
for _ in range(rects):
    hdr = recvall(s, 12)
    x, y, rw, rh, enc = struct.unpack(">HHHHi", hdr)
    if enc != 0:
        raise SystemExit(f"unsupported encoding {enc}")
    step = bpp // 8
    raw = recvall(s, rw * rh * step)
    endian = "big" if bigend else "little"
    pos = 0
    for yy in range(rh):
        for xx in range(rw):
            val = int.from_bytes(raw[pos : pos + step], endian)
            pos += step
            r = ((val >> rshift) & redmax) * 255 // redmax
            g = ((val >> gshift) & greenmax) * 255 // greenmax
            b = ((val >> bshift) & bluemax) * 255 // bluemax
            off = ((y + yy) * w + (x + xx)) * 3
            rgb[off : off + 3] = bytes((r, g, b))

with open(out, "wb") as f:
    f.write(f"P6\n{w} {h}\n255\n".encode("ascii"))
    f.write(rgb)

print(out)
