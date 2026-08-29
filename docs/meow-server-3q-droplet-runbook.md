# Meow Server / 3Q Droplet Runbook

Ngày ghi chú: 2026-08-11  
Droplet: `meow-server`  
IP public: `104.248.157.207`  
OS: Ubuntu 22.04.5 LTS  
3Q live root: `/opt/3q-test`

## 1. Hiện trạng đã kiểm

- RAM hiện tại: khoảng 4GB.
- Swap: 4GB.
- Disk `/`: 78GB, đã dùng khoảng 27GB, còn khoảng 51GB.
- Source 3Q live: `/opt/3q-test/home/web`.
- Web game 3Q: port `8085`.
- Game service chính: `3q-test.service`.
- Unit systemd: `/etc/systemd/system/3q-test.service`.
- Script start: `/opt/3q-test/deploy/3q-test/start.sh`.
- Script stop: `/opt/3q-test/deploy/3q-test/stop.sh`.
- Script status: `/opt/3q-test/deploy/3q-test/status.sh`.

## 2. Lệnh kiểm tra nhanh

```bash
systemctl status 3q-test --no-pager -l
bash /opt/3q-test/deploy/3q-test/status.sh
ss -ltnp | grep -E ':8085|:12345|:7788|:5000|:8001|:9000|:9999|:30001|:20001'
free -h
df -h /
```

## 3. Tắt game 3Q trước khi resize

```bash
systemctl stop 3q-test
docker stop 3q-test-mongo 3q-test-rabbit
bash /opt/3q-test/deploy/3q-test/status.sh
ss -ltnp | grep -E ':8085|:12345|:7788|:5000|:8001|:9000|:9999|:30001|:20001'
```

Kết quả mong muốn:

- `status.sh` báo các process 3Q stopped.
- Lệnh `ss` không còn port 3Q nào listen.
- `docker ps --filter name=3q-test` không còn container running.

Nếu còn process treo:

```bash
pkill -f '/opt/3q-test' || true
pkill -f 'php -S 0.0.0.0:8085' || true
```

## 4. Bật lại game sau khi nâng cấu hình

```bash
docker start 3q-test-mongo 3q-test-rabbit
systemctl start 3q-test
bash /opt/3q-test/deploy/3q-test/status.sh
curl -I --max-time 5 http://127.0.0.1:8085/client/game
```

Kết quả mong muốn:

- `web` running, port `8085`.
- `socket` running, port `5000`.
- `login` running, port `9000`.
- `game` running, port `8001`.
- Web trả `HTTP/1.1 200 OK`.

Nếu cần restart:

```bash
systemctl restart 3q-test
```

## 5. Service 3Q đang chạy gì

`start.sh` khởi động:

- Docker: `3q-test-mongo`, `3q-test-rabbit`.
- Node socket: `/opt/3q-test/home/web/socket/src/index.js`, port `5000`.
- PHP web: `/opt/3q-test/home/web`, port `8085`.
- Java:
  - console: `9999`
  - login: `9000`
  - world: `10086`
  - meta: `12345`
  - statistic: `7788`
  - pay: `10010`
  - group: `30001`
  - cross: `20001`
  - game s1: `8001`

## 6. Checklist nâng cấu hình DigitalOcean

1. Tạo snapshot/backup nếu có nút snapshot.
2. SSH vào server.
3. Chạy `systemctl stop 3q-test`.
4. Kiểm tra không còn port 3Q listen.
5. Vào DigitalOcean → Droplet → Resize.
6. Chọn gói CPU/RAM cao hơn.
7. Bật lại Droplet nếu resize yêu cầu power cycle.
8. SSH lại.
9. Chạy `systemctl start 3q-test`.
10. Mở `http://104.248.157.207:8085/client/game` để test.

## 7. Link tài liệu DigitalOcean

- Resize Droplets: https://docs.digitalocean.com/products/droplets/how-to/resize/
- Power cycle / Power off Droplets: https://docs.digitalocean.com/products/droplets/how-to/power/
- Snapshots Droplets: https://docs.digitalocean.com/products/snapshots/how-to/snapshot-droplets/
