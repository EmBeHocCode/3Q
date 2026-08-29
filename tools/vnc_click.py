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


x = int(sys.argv[1])
y = int(sys.argv[2])
s = connect()
s.sendall(struct.pack(">BBHH", 5, 0, x, y))
time.sleep(0.05)
s.sendall(struct.pack(">BBHH", 5, 1, x, y))
time.sleep(0.08)
s.sendall(struct.pack(">BBHH", 5, 0, x, y))
print("clicked", x, y)
