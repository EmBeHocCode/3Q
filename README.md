# 3Q Game Web/Server Source

Source này là bộ triển khai game 3Q gồm phần web, server Java, socket Node.js, dữ liệu SQL, script deploy và một số công cụ hỗ trợ vận hành/test trên VPS.

README này viết theo kiểu “mở ra là biết làm gì”, ưu tiên dễ đọc, dễ sửa, dễ deploy lại.

## 1. Source này có gì?

| Thư mục/file | Vai trò |
|---|---|
| `home/web/` | Web chính của game: trang client, API PHP, tài nguyên H5, socket Node.js. |
| `h5/server/` | Các service Java của game: login, world, game, cross, group, pay, statistic, console, meta. |
| `Tools Event/` | SQL gốc, tool build/event, file cấu hình sự kiện, tài liệu thao tác. |
| `deploy/3q-test/` | Script deploy nhanh trên Linux/VPS: setup, start, stop, status. |
| `tools/` | Script debug/sửa lỗi đã dùng trong quá trình vận hành VPS, Windows Server, web, APK/client. |
| `usr/local/` | Runtime đi kèm: JDK, MongoDB package, RabbitMQ/Erlang package. |
| `docs/` | Ghi chú vận hành, runbook VPS. |
| `www/` | Bản web/server phụ hoặc bản mirror từ source cũ. |
| `scripts/` | Script patch dữ liệu, cân bằng event, sửa UI/game/web. |

## 2. Yêu cầu môi trường khuyến nghị

### VPS/Linux

- Ubuntu 22.04 LTS hoặc tương đương.
- RAM tối thiểu 4GB, khuyến nghị 8GB nếu chạy đủ service.
- CPU tối thiểu 2 vCPU, khuyến nghị 4 vCPU.
- Disk trống tối thiểu 20GB.
- Cần có: `bash`, `java`, `mysql` hoặc `mariadb`, `php`, `node`, `npm`, `docker`.

### Web/PHP

- PHP có extension:
  - `pdo_mysql`
  - `curl`
  - `mbstring`
  - `json`

### Node socket

- Node.js 16+ hoặc 18+.
- Cài dependency tại:

```bash
cd home/web/socket
npm ci
```

### Java server

- Source có kèm JDK trong `usr/local/jdk/`.
- Script deploy mặc định dùng:

```bash
/opt/3q-test/usr/local/jdk/bin/java
```

## 3. Các port chính

| Port | Service |
|---:|---|
| `8085` | Web game / client |
| `5000` | Node socket |
| `9000` | Login server |
| `8001` | Game server S1 |
| `10086` | World server |
| `12345` | Meta server |
| `7788` | Statistic server |
| `10010` | Pay server |
| `30001` | Group server |
| `20001` | Cross server |
| `27018` | MongoDB Docker forward nội bộ |
| `5672` | RabbitMQ Docker forward nội bộ |

Nếu chạy public VPS, nhớ mở firewall đúng port cần dùng. Không nên mở MongoDB/RabbitMQ ra ngoài Internet.

## 4. Deploy nhanh trên VPS Linux

Ví dụ deploy vào `/opt/3q-test`.

### Bước 1: copy source lên VPS

```bash
cd /opt
git clone https://github.com/EmBeHocCode/3Q.git 3q-test
cd /opt/3q-test
```

Nếu repo dùng Git LFS, sau khi clone cần kéo file lớn:

```bash
git lfs pull
```

### Bước 2: cài gói nền

```bash
apt update
apt install -y mysql-server php-cli php-curl php-mysql nodejs npm docker.io
```

### Bước 3: chạy setup

```bash
bash /opt/3q-test/deploy/3q-test/setup.sh
```

Script này sẽ:

1. Tạo file `.secrets` chứa user/password database runtime.
2. Patch IP public vào cấu hình server.
3. Tạo database `tcg`, `stat`, `WEB`, `cdks`, `game_s1`.
4. Import SQL gốc trong `Tools Event/sql/`.
5. Tạo Docker container MongoDB và RabbitMQ.
6. Cài dependency Node socket nếu chưa có `node_modules`.

### Bước 4: start server

```bash
bash /opt/3q-test/deploy/3q-test/start.sh
```

### Bước 5: kiểm tra trạng thái

```bash
bash /opt/3q-test/deploy/3q-test/status.sh
```

Khi ổn, các service chính nên hiện `running` và các port phải listen.

## 5. Dùng systemd để server tự chạy lại

File service mẫu nằm tại:

```text
deploy/3q-test/3q-test.service
```

Cài service:

```bash
cp /opt/3q-test/deploy/3q-test/3q-test.service /etc/systemd/system/3q-test.service
systemctl daemon-reload
systemctl enable --now 3q-test
```

Kiểm tra:

```bash
systemctl status 3q-test --no-pager -l
```

Restart:

```bash
systemctl restart 3q-test
```

Stop:

```bash
systemctl stop 3q-test
```

## 6. Cấu hình IP/domain

IP public mặc định trong script deploy đang là:

```text
104.248.157.207
```

Nếu đổi VPS/domain, sửa trong:

```text
deploy/3q-test/setup.sh
deploy/3q-test/configure.py
```

Dòng cần chú ý trong `setup.sh`:

```bash
PUBLIC_IP=104.248.157.207
```

Sau khi sửa IP, chạy lại:

```bash
bash /opt/3q-test/deploy/3q-test/setup.sh
systemctl restart 3q-test
```

## 7. Database

Các database chính:

| Database | Dùng cho |
|---|---|
| `tcg` | Data chính của game/web |
| `stat` | Thống kê |
| `WEB` | Web/account/admin |
| `cdks` | Giftcode/CDK |
| `game_s1` | Dữ liệu server S1 |

SQL gốc nằm tại:

```text
Tools Event/sql/tcg.sql
Tools Event/sql/stat.sql
Tools Event/sql/WEB.sql
Tools Event/sql/cdks.sql
```

Import thủ công nếu cần:

```bash
mysql tcg < "/opt/3q-test/Tools Event/sql/tcg.sql"
mysql stat < "/opt/3q-test/Tools Event/sql/stat.sql"
mysql WEB < "/opt/3q-test/Tools Event/sql/WEB.sql"
mysql cdks < "/opt/3q-test/Tools Event/sql/cdks.sql"
```

## 8. Chạy từng phần khi debug

### Web

```bash
php -S 0.0.0.0:8085 -t /opt/3q-test/home/web
```

Test:

```bash
curl -I http://127.0.0.1:8085/client/game
```

### Socket

```bash
cd /opt/3q-test/home/web/socket
npm ci
node src/index.js
```

### Game Java

Nên ưu tiên dùng script:

```bash
bash /opt/3q-test/deploy/3q-test/start.sh
```

Vì service Java cần đúng working directory, đúng jar, đúng tham số `--v`, `--sc`, `--gc`, `--cc`, `--p`.

## 9. Kiểm tra lỗi nhanh

### Xem process/port

```bash
ps aux | grep -E 'tcg|java|node|php' | grep -v grep
ss -ltnp | grep -E ':8085|:5000|:9000|:8001|:10086|:12345|:7788|:10010|:30001|:20001'
```

### Xem log

Log runtime mặc định nằm trong:

```text
/opt/3q-test/logs/
```

Ví dụ:

```bash
tail -100 /opt/3q-test/logs/game.log
tail -100 /opt/3q-test/logs/login.log
tail -100 /opt/3q-test/logs/web.log
tail -100 /opt/3q-test/logs/socket.log
```

## 10. Lỗi thường gặp

### Web mở được nhưng không vào game

Nguyên nhân hay gặp:

1. Client đang trỏ sai IP/port.
2. Login server `9000` chưa chạy.
3. Game S1 `8001` chưa chạy.
4. Web serverlist trả sai IP.
5. Firewall/VPS chưa mở port.

Cách kiểm tra:

```bash
bash /opt/3q-test/deploy/3q-test/status.sh
curl http://127.0.0.1:8085/serverlist.txt
```

### Bấm vào game bị “đang tải”

Ưu tiên kiểm tra:

1. Log `game.log`.
2. Log `login.log`.
3. Port `8001`.
4. IP trong cấu hình client/serverlist.
5. Database `game_s1`.

### Apache/PHP lỗi extension

Kiểm tra:

```bash
php -m | grep -E 'pdo_mysql|curl'
```

Nếu thiếu:

```bash
apt install -y php-mysql php-curl
```

### Node socket không chạy

```bash
cd /opt/3q-test/home/web/socket
npm ci
node src/index.js
```

Nếu lỗi module, xóa `node_modules` rồi cài lại:

```bash
rm -rf node_modules
npm ci
```

## 11. Backup/restore

### Backup database

```bash
mkdir -p /opt/backup-3q
mysqldump tcg > /opt/backup-3q/tcg.sql
mysqldump stat > /opt/backup-3q/stat.sql
mysqldump WEB > /opt/backup-3q/WEB.sql
mysqldump cdks > /opt/backup-3q/cdks.sql
mysqldump game_s1 > /opt/backup-3q/game_s1.sql
```

### Restore database

```bash
mysql tcg < /opt/backup-3q/tcg.sql
mysql stat < /opt/backup-3q/stat.sql
mysql WEB < /opt/backup-3q/WEB.sql
mysql cdks < /opt/backup-3q/cdks.sql
mysql game_s1 < /opt/backup-3q/game_s1.sql
```

## 12. Lưu ý bảo mật

- Không commit file `.secrets`, `.env`, private key, cert thật.
- Không mở port database ra public Internet.
- Đổi mật khẩu MySQL/MongoDB/RabbitMQ trước khi chạy production.
- Nếu repo public, nên rà lại các file config có password mẫu trước khi chia sẻ rộng.
- Nên backup database trước khi patch event, patch shop hoặc đổi cấu hình server.

## 13. Ghi chú Git LFS

Repo này có nhiều file runtime/build lớn như `.jar`, `.rar`, `.tar.gz`, `.tgz`, `.so`.

Vì GitHub giới hạn file thường rất chặt, các file lớn được cấu hình qua Git LFS trong `.gitattributes`.

Máy clone repo cần cài Git LFS:

```bash
git lfs install
git lfs pull
```

## 14. License

Chưa xác định license. Nếu dùng nội bộ, giữ private repository. Nếu public, cần tự kiểm tra quyền phân phối source, assets, tool, binary runtime và dữ liệu game.
