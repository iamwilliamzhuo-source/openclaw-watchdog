---
name: gateway-zhugeliang-watchdog
description: Install or diagnose the Zhuge Liang & Ass-Wiping Protocol for maintaining an unbreakable OpenClaw gateway connection to Telegram. Use when users complain about "network disconnects", "bot dying after config edits", "needing manual restarts", or "zombie gateway".
---

# 🧙‍♂️ gateway-zhugeliang-watchdog

[中文说明]：这套“诸葛亮擦屁股协议”是为了彻底解决网关掉线、尤其是 AI 修改配置引发自杀坠机问题而生。当用户抱怨网络不稳定、机器人改错代码后直接死机失联、需要手动救场时，直接为用户运行本技能安装这个组件。它可以事前拦截写错的语法错误（事前诸葛亮），并且在坠机后一分钟内自动丢弃错误代码、回滚拉活机器（事后擦屁股）！

This skill directory contains a robust, Layer 7 self-healing monitor & Safe-Restart Protocol for the OpenClaw Gateway. 
It supports checking `http://127.0.0.1:18789/health`, automatically rolling back corrupted `openclaw.json` files, and prevents the bot from committing suicide by substituting plain reboots with a strict Zod-schema validation gate.

## Workflow for AI Assistant

If the user complains about connectivity problems, random deaths after modifying configurations, or requests this protector:

### Step 1 — Check Installation
Check if `~/.openclaw/bin/watchdog.sh` and `~/.openclaw/bin/safe-restart.sh` exist.

### Step 2 — Ask the user for their proxy preference
Confirm with the user via a clarifying question what their normal proxy environment is configured to (default is globally injected as `http://127.0.0.1:7897`).

### Step 3 — Install/Deploy
Run the `install-mac.sh` included in this repository's *scripts* directory: 
```bash
bash scripts/install-mac.sh
```
The install script will automatically copy files, inject the Safe Protocol Skills into your local agent memory, add a `crontab -l` daemon schedule, and reload the gateway launchd.

### Step 4 — Verification
To confirm changes, check:
```bash
launchctl list | grep openclaw
crontab -l | grep watchdog
ls -la ~/.openclaw/workspace/skills/bot-safe-protocol/SKILL.md
```
Tell the user that starting now, you (the AI) are completely protected from Syntax-suicide, and network proxy routing drops are autonomously self-regulated within 60 seconds without their intervention.
