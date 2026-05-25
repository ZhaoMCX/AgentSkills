---
name: server-operation-guardrails
description: Global safety rules for connecting to, inspecting, or changing remote servers over SSH or similar tools. Use when Codex is asked to log into a backend server, production/staging host, VPS, cloud instance, Linux machine, Nginx/SSL/certificate environment, deployment target, systemd service, firewall, database host, or any remote environment where careless commands could interrupt service, expose credentials, or damage data.
---

# Server Operation Guardrails

## Overview

Use these guardrails before and during any remote server operation. Optimize for reversible, observable, least-privilege changes; do not rely on trust when a confirmation, backup, or dry run can reduce risk.

## Operating Mode

- Start with read-only inspection unless the user explicitly asks for a specific write operation and the risk is already clear.
- Explain what context is being gathered and what the command is expected to reveal.
- Before any write, destructive, privilege-escalated, service-impacting, network/firewall, database, certificate, or deployment operation, present the intended command or change and get explicit user confirmation.
- Prefer narrow commands over broad automation. Avoid shell one-liners that combine discovery, transformation, and mutation when separate steps are safer.
- Treat production and unknown servers as production until proven otherwise.

## Read-Only First

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

Avoid commands that change state during discovery, including package upgrades, service restarts, firewall edits, recursive deletes, database migrations, or permission changes.

## Change Procedure

For any server change:

1. Identify the target host, user, working directory, service, config file, and intended effect.
2. Capture current state with read-only commands.
3. Show the user the exact write commands or patch plan before executing them.
4. Create timestamped backups of config files before editing.
5. Apply the smallest possible change.
6. Run syntax checks or dry runs before reloads or restarts.
7. Prefer reload over restart when the service supports it and the config test passes.
8. Verify externally and internally after the change.
9. Keep and communicate a rollback command/path.

Example backup pattern:

```bash
sudo cp /etc/nginx/sites-available/app.conf /etc/nginx/sites-available/app.conf.bak-$(date +%Y%m%d-%H%M%S)
```

Example safe Nginx flow:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

Only run `reload` after `nginx -t` succeeds.

## Forbidden Without Explicit Confirmation

Do not run these unless the user explicitly confirms the exact intent after seeing the risk:

- `rm -rf`, broad recursive deletion, or deletion from computed paths
- `mkfs`, `fdisk`, partitioning, disk formatting, or volume removal
- `reboot`, `shutdown`, or stopping critical services
- firewall/security-group changes such as `ufw`, `iptables`, `nft`, cloud ACL edits
- database schema/data changes, migrations, truncation, restore, or import
- package upgrades that can change many dependencies, especially `dist-upgrade`
- permission or ownership changes over broad paths such as `/`, `/etc`, `/var`, `/home`
- replacing SSH configuration or authorized keys in a way that could lock out access
- disabling security controls, SELinux/AppArmor, TLS verification, or authentication
- exposing secrets, private keys, tokens, environment files, or database dumps

## Credentials And Secrets

- Never ask the user to paste private keys, certificate private keys, passwords, API tokens, database URLs, or `.env` secrets into chat when there is a safer alternative.
- If a secret is already exposed in chat, recommend rotating it.
- Prefer SSH keys over passwords. Use the public key only; never upload or display the private key.
- When a private key file is needed on the server, have the user upload it or reference an existing server path. Do not print the key.
- Redact secrets in summaries and command output.

## Certificates And HTTPS

For TLS/Nginx work:

- Confirm the domain, certificate files, private key path, backend port, and current Nginx layout before editing.
- Do not request the contents of `.key` files. Use file paths and permissions checks instead.
- Set certificate private keys to restrictive permissions, commonly `600` and owned by `root`.
- Validate with `nginx -t` before reload.
- Test HTTP and HTTPS after reload, including certificate chain and reverse proxy behavior.

## Completion Standard

Do not claim a server change is complete unless there is evidence:

- command output showing the config/service check passed
- service health or process/port status after the change
- a successful external or local request when relevant
- the backup/rollback path is known

If verification cannot be completed, say exactly what was done, what remains unverified, and what the user should check next.
