---
name: gateway-smart-watchdog
description: Install or diagnose the Smart Auto-Proxy Watchdog skill for maintaining reliable OpenClaw gateway connection to Telegram. Use when users complain about "network disconnects", "gateway zombie", "needing manual restarts", or "switching VPNs breaks the bot connection".
---

# gateway-smart-watchdog

This skill directory contains a robust, Layer 7 self-healing monitor for the OpenClaw Gateway. 
It supports checking `http://127.0.0.1:18789/health` and automatically rewriting `openclaw.json` (via CLI) if it detects a network change (direct route vs local HTTP proxy).

## Workflow for AI Assistant

If the user complains about connectivity problems or requests this skill:

### Step 1 — Check Installation
Check if `~/.openclaw/bin/watchdog.sh` exists.

### Step 2 — Ask the user for their proxy preference
Confirm with the user via a clarifying question what their normal proxy port is configured to (default is `http://127.0.0.1:7897`).

### Step 3 — Install/Deploy
Run the `install-mac.sh` included in this repository's *scripts* directory: 
```bash
bash scripts/install-mac.sh
```
The install script will automatically copy files, add a `crontab -l` daemon schedule, and reload the gateway launchd.

### Step 4 — Verification
To confirm changes, check:
```bash
launchctl list | grep openclaw
crontab -l | grep watchdog
openclaw config get channels.telegram.proxy
tail -5 ~/.openclaw/logs/watchdog.log
```
Tell the user that starting now, network failures and proxy routing drops are autonomously self-regulated within 60 seconds without their intervention.
