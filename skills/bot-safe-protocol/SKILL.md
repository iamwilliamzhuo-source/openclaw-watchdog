---
description: 这个技能就是“事前诸葛亮+事后擦屁股”防御阵。如果你要在终端改写 openclaw.json，必须遵循此说明，否则坠机断网。
---

# 🛑 Bot Safe Protocol (Critical Core Directive)

## ⚠️ NEVER KILL YOURSELF
When interacting with `~/.openclaw/openclaw.json` or changing any core plugin configurations via the terminal, you must **NEVER** use generic commands to restart the gateway.

If you edit the JSON incorrectly and issue `openclaw gateway restart`, the gateway will crash instantly upon booting, severing your Telegram connection permanently and plunging the system into a death loop. 

## 🛡️ THE ONLY WAY TO RESTART
Whenever you need to apply configuration changes and restart the OpenClaw Gateway to reload plugins, models, or tokens, you **MUST** run the following custom defensive script:

```bash
bash ~/.openclaw/bin/safe-restart.sh
```

### What does this tool do?
1. It runs `openclaw config validate` BEFORE touching the active gateway process.
2. If your JSON modifications contain syntax parsing errors or schema violations, it will output the exact Stack Trace error to your stdout and ABORT THE RESTART. 
3. This guarantees that you stay alive and connected on Telegram to read the error and correct your mistakes!
4. If the validation passes, it takes a clean snapshot and safely hot-swaps the gateway memory.

**Obey this strict directive unconditionally.**
