set -eu
svc=/etc/systemd/system/winserver2022.service
cp "$svc" "/opt/win-vm/winserver2022.service.backup-langla-$(date +%Y%m%d-%H%M%S)"
if ! grep -q 'hostfwd=tcp::2907-:2907' "$svc"; then
  perl -0pi -e 's/(hostfwd=tcp::20004-:20004)/$1,hostfwd=tcp::2907-:2907/' "$svc"
fi
systemctl daemon-reload
systemctl restart winserver2022
sleep 50
systemctl is-active winserver2022
grep -o 'hostfwd=tcp::[0-9]*-[^, \\]*' "$svc"
ss -ltnp | grep -E ':2907|:3390|:5901|:2222' || true
