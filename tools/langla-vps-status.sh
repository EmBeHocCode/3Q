set -eu
grep -nE 'hostfwd|winserver2022|3390|5901|2907' /etc/systemd/system/winserver2022.service || true
systemctl status winserver2022 --no-pager -l | head -18 || true
ss -ltnp | grep -E ':2907|:3390|:5901' || true
