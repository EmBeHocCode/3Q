import socket
import struct
import sys
import time


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
    time.sleep(0.015)
    s.sendall(struct.pack(">BBHI", 4, 0, 0, keysym))
    time.sleep(0.04)


def press_shifted(s, keysym):
    shift_l = 0xFFE1
    s.sendall(struct.pack(">BBHI", 4, 1, 0, shift_l))
    time.sleep(0.015)
    press(s, keysym)
    s.sendall(struct.pack(">BBHI", 4, 0, 0, shift_l))
    time.sleep(0.04)


text = " ".join(sys.argv[1:])
text = text.replace("\\n", "\n")
s = connect()
for ch in text:
    if ch == "\n":
        press(s, 0xFF0D)
    elif ch == ":":
        press_shifted(s, ord(";"))
    elif ch == "{":
        press_shifted(s, ord("["))
    elif ch == "}":
        press_shifted(s, ord("]"))
    else:
        press(s, ord(ch))
print("typed", len(text), "chars")
