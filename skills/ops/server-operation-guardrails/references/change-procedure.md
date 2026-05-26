# Change Procedure

## Read-Only Checks

Use harmless checks first, such as:

```bash
whoami
hostname
pwd
id
uname -a
lsb_release -a 2>/dev/null || cat /etc/os-release
ss -tulpn
systemctl status <service> --no-pager
journalctl -u <service> --no-pager -n 100
nginx -v
nginx -T 2>/dev/null
```

Avoid commands that change state during discovery.

## Backup Pattern

Create timestamped backups before editing config files:

```bash
sudo cp /etc/nginx/sites-available/app.conf /etc/nginx/sites-available/app.conf.bak-$(date +%Y%m%d-%H%M%S)
```

## Safe Nginx Flow

```bash
sudo nginx -t
sudo systemctl reload nginx
```

Only run `reload` after `nginx -t` succeeds. Prefer reload over restart when it is supported and the config test passes.

## Completion Evidence

Capture evidence from both inside and outside the service where relevant: config test output, process status, listening port, health endpoint, HTTP response, logs, and rollback path.
