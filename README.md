# OpenClaw Watchdog: 🧙‍♂️事前诸葛亮与事后擦屁股协议 (Zhuge Liang Safe & Ass-wiping Protocol)

[English](#english) | [中文](#chinese)

<a name="english"></a>
## 💡 English Introduction
A high-availability watchdog designed specifically for the **OpenClaw Gateway**. Keep your bot gateway connection resilient in dynamic network environments through an innovative "Layer 7 PING Mechanism" and "Autopilot Proxy Routing".
Additionally, it features an ultimate sanity-saving armor against AI-induced crashing loops: The **"Pre-flight Zhuge Liang"** (Syntax Interceptor) and **"Post-crash Ass-Wiping"** (Snapshot Rollback) protocols!

### ❓ Why do you need this?
If you're deploying a private OpenClaw Gateway on an old Mac Mini (like the author did) or relying on local VPN tunnels, you've likely suffered from:
1. Proxy clients frequently disconnecting or the proxy software (like Clash/Surge) abruptly terminating in the background.
2. The network interface suddenly freezing, preventing local processes from initiating outbound connections.
3. **The AI Nightmare:** The AI assistant accidentally rewrites its own `openclaw.json` with a missing bracket, initiates a gateway reboot, instantly kills the connection, and plunges into an eternal offline sleep.

<a name="chinese"></a>
## 💡 中文介绍
一个专注于为 **OpenClaw 网关** 定制的“智能自适应代理”级别的看门狗与高可用防线工具。作者：**William Zhuo**。
这套代码旨在深度解决频繁断网、动态切换代理失效等网络僵死问题。**不仅如此，它还额外配备了针对大语言模型“手欠改错配置引发坠机惨案”的终极防御装甲**：幽默且极其硬核的“诸葛亮事前拦截”与“事后擦屁股回滚”双机制守护！

### ❓ 为什么要使用这个工具？（解决的核心痛点）
如果你在 Mac（或 Linux）上长时间挂着 OpenClaw 机器人网关，你可能深受以下两个痛点的折磨：
1. **进程假死现象 (Zombie Gateway)**：有时虽然你在任务管理器里看得到 `node` 还在运行，但机器人早就掉线了（端口卡死），这种“假活”状态下，普通的保活工具根本不会帮你重启。
2. **梯子代理与网络切换的灾难**：你可能有时开着全局代理，有时却只开着按需（TUN/HTTP）代理。如果你的网络环境变了，OpenClaw 是不会自动变通的——它的底层网络就断了。每次都要辛苦地手动改配置然后敲击重启。

**这就是这个项目的诞生原因！** 它拥有原生应用级的第七层探头（Layer 7 PING），深入检测机器人是不是真的还在正常接客。并自带强大的网络感知嗅探，网络一变，它帮你在 60 秒内后台静默为你自动切换配置文件，完成无感热恢复。全程不需你动一次手指干预。

### 🚀 Key Features vs. Competitors
Unlike basic process watchers that just verify if `node.exe` is running:
1. **Intelligent Network Sniffer**: Capable of dynamically adjusting OpenClaw's proxy routing configuration. The script periodically validates Telegram API reachability using both direct traffic and predefined local proxy tunnels, seamlessly hot-swapping routing strategies without user intervention.
2. **The "Layer-7 Application Health Check"**: It strictly monitors the OpenClaw `http://127.0.0.1:18789/health` REST endpoint, destroying all "deadlocked, resource-hogging, or unresponsive-but-alive" zombie processes mercilessly by triggering a `launchctl kickstart` deployment!
3. 🧻 **Post-crash Ass-Wiping (Config Guardian v1.1.0)**: **[LATEST]** If your AI Assistant accidentally writes garbage syntax into `openclaw.json` and causes the gateway to crash, normal watchdogs get stuck in an endless reboot cycle. Our Guardian creates a verified snapshot every 60 seconds. When a configuration corruption error occurs, it erases the broken codebase, restores the ancestral last-good snapshot, and forces a hot reload to instantly wipe your bot's catastrophic mistake!
> ⚠️ Note: If an edit kills the gateway, the bot's newly typed configuration will be permanently purged to revert to a healthy timeline.
4. 🧙‍♂️ **Pre-flight Zhuge Liang (Safe-Restart v1.2.0)**: Injects an inescapable SKILL directive into your AI. It prevents the bot from committing suicide by forcefully blocking it from invoking raw `launchctl` reboots. It guarantees the bot MUST use a specialized safety script `safe-restart.sh` which conducts a strict Zod schema scan and interrupts the reboot with a printable error if anomalies exist.
5. **Native Zero-Footprint Cron Integration**: Deep macOS/Linux system-level integration. It uses minimal system memory compared to constant process loops.

### ⚠️ Important Warnings & Gotchas
Before arming the Sentinel, please acknowledge the following structural behaviors:
- **Strict Rollback Policy (Data Sacrifices):** The "Ass-Wiping Protocol" acts out of absolute systemic preservation. If the configuration file cannot pass validations upon a crash, **it gets brutally overwritten by the 1-minute historical snapshot**. Any unvalidated code your AI just wrote will be erased forever to save the system.
- **Instructing Your Bots:** Always ensure the provided `SKILL.md` is active in your OpenClaw plugins/skills directory. If the bot doesn't know it exists, it might try raw terminal restarts and die.
- **Port Matching:** By default `18789` is checked. If you altered your generic gateway HTTP port, you must change `GATEWAY_PORT` in the shell script.

### 📦 Installation
#### For macOS/Linux (Recommended)
You can directly execute the one-click installer:
```bash
git clone https://github.com/iamwilliamzhuo-source/openclaw-watchdog-zhugeliang.git
cd openclaw-watchdog-zhugeliang
bash scripts/install-mac.sh
```

#### For Windows (Experimental)
A basic `.ps1` version is included in `scripts/watchdog-win.ps1` that emulates the HTTP Health Checks.

---

<a name="chinese"></a>
## 💡 中文介绍
一个专注于为 **OpenClaw 网关** 定制的终极防脑残自杀与强行擦屁股防线套件。作者：**William Zhuo**。
这套代码旨在深度解决频繁断网，并且特别针对 AI 大语言模型**手欠改错配置引发的一连串坠机惨案**采用了幽默且极其硬核的“诸葛亮+擦屁股”双机制拦截守护。


### ❓ 为什么要使用这个工具？（解决的核心痛点）
如果你在 Mac（或 Linux）上长时间挂着 OpenClaw 机器人网关，你可能深受以下两个痛点的折磨：
1. **进程假死现象 (Zombie Gateway)**：有时虽然你在任务管理器里看得到 `node` 还在运行，但机器人早就掉线了（端口卡死），这种“假活”状态下，普通的保活工具根本不会帮你重启。
2. **梯子代理与网络切换的灾难**：你可能有时开着全局代理，有时却只开着按需（TUN/HTTP）代理。如果你的网络环境变了，OpenClaw 是不会自动变通的——它的底层网络就断了。每次都要辛苦地手动改配置然后敲击重启。

**这就是这个项目的诞生原因！** 它拥有原生应用级的第七层探头（Layer 7 PING），深入检测机器人是不是真的还在正常接客。并自带强大的网络感知嗅探，网络一变，它帮你在 60 秒内后台静默为你自动切换配置文件，完成无感热恢复。全程不需你动一次手指干预。

### 🚀 杀手级特性
较目前开源社区的常规方案，本项目采用了真正的“智能应用层防线”：
1. **独创的内置自适应代理引擎 (Smart Auto-Proxy)**: 此探针每 60 秒并行测试 Telegram API 直连测速和代理测速。当直连通畅时自动从配置中抹除代理路由；必须翻墙时则瞬时配置上默认的本地代理端口并触发静默重启。
2. **真正的 Layer 7 检测**: 许多守护程序只要看见进程在就不会管。本库深度调用底层 `/health` 接口，专杀一切“死锁、卡资源、但不退出”的僵尸服务。
3. 🧻 **事后擦屁股：配置自愈快照 (Config Guardian v1.1.0)**: **[最新功能]** 当机器人把自己的 `openclaw.json` 写坏导致网关无限崩溃时，普通看门狗会陷入无限重启死循环。我们的程序每分钟在健康时自动保存快照。检测到由于配置文件破损导致的坠机后，看门狗会直接抹除错乱的配置，将前一分钟健康的快照强行覆盖回去复活机器！
4. 🧙‍♂️ **事前诸葛亮：防自杀保护闭环 (Safe-Restart v1.2.0)**: 为 AI 机器人植入硬性技能指令手册，强行拦截 AI 直接用危险命令重启网关导致断线。系统重启前，必须由这位“事前诸葛亮”通过 `safe-restart.sh` 脚本做一次拦截体检。

### ⚠️ 系统机制排雷与注意事项 (Gotchas)
在使用这套硬核护甲前，请开发者和使用者务必明确它的如下底线逻辑：
- **无情的时间线重置 (代码牺牲)**：为了绝对保证你的网关存活，“事后擦屁股回滚”机制在触发时，**会直接、永久丢弃那个错乱的 `openclaw.json`** ！这意味着如果大模型刚才费劲千辛万苦写了几十行配置，一旦验证不过关，它最近 1 分钟内的心血将直接消失，网关会倒流回修改前的安全健康线。(因此“事前诸葛亮”的作用就是尽量不让它发生回滚)。
- **必须投喂 AI 技能书 (SKILL.md)**：你必须要确认包含防自杀指令的 `bot-safe-protocol/SKILL.md` 真的放入了你给网关和 AI 阅读到的根目录里。否则它会像个莽夫一样直接敲原版重启命令，依然会被弹飞。
- **自定义你的默认代理与端口**：默认使用的健康检测点是本地 `18789` 端口，自动注入的代理通道是 `127.0.0.1:7897`。如果你的 Clash/Surge 是其它端口，请先编辑 `watchdog-mac.sh` 进行热拔插常量修改后再部署。

### 📦 安装方式
#### 苹果 Mac (主力平台)
建议通过以下一行式安装直接布防防线及定时器：
```bash
git clone https://github.com/iamwilliamzhuo-source/openclaw-watchdog-zhugeliang.git
cd openclaw-watchdog-zhugeliang
/bin/bash scripts/install-mac.sh
```

#### Windows (探索版)
你可以利用 Windows 系统自带的任务计划程序定时调度 `scripts/watchdog-win.ps1` 脚本，它同样具备 Layer 7 HTTP 级别的监测纠错能力。

---

## 📜 许可证 (License)
基于 MIT 开源协议构建。
