import socket
import struct
import sys
import time

KEYS = {
    "enter": 0xFF0D,
    "tab": 0xFF09,
    "esc": 0xFF1B,
    "space": 0x0020,
    "up": 0xFF52,
    "down": 0xFF54,
    "left": 0xFF51,
    "right": 0xFF53,
    "f8": 0xFFC5,
    "f10": 0xFFC7,
    "shift": 0xFFE1,
}


def recvall(sock, size):
    data = b""
    while len(data) < size:
        chunk = sock.recv(size - len(data))
        if not chunk:
            raise EOFError("socket closed")
        data += chunk
    return data


def connect():
    s = socket.create_connection(("127.0.0.1", 5901), timeout=10)
    proto = recvall(s, 12)
    s.sendall(proto)
    n = recvall(s, 1)[0]
    types = recvall(s, n)
    if 1 not in types:
        raise SystemExit("no None security")
    s.sendall(b"\x01")
    recvall(s, 4)
    s.sendall(b"\x01")
    init = recvall(s, 24)
    name_len = struct.unpack(">I", init[20:24])[0]
    recvall(s, name_len)
    return s


def press(s, keysym):
    s.sendall(struct.pack(">BBHI", 4, 1, 0, keysym))
    time.sleep(0.05)
    s.sendall(struct.pack(">BBHI", 4, 0, 0, keysym))
    time.sleep(0.2)


s = connect()
args = sys.argv[1:] or ["enter"]
if len(args) == 1 and args[0].lower() == "shift_f10":
    s.sendall(struct.pack(">BBHI", 4, 1, 0, KEYS["shift"]))
    time.sleep(0.05)
    press(s, KEYS["f10"])
    s.sendall(struct.pack(">BBHI", 4, 0, 0, KEYS["shift"]))
else:
    for name in args:
        press(s, KEYS[name.lower()])
print("sent", " ".join(sys.argv[1:] or ["enter"]))
