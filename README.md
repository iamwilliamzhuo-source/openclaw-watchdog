# 🧙‍♂️OpenClaw 诸葛亮擦屁股协议 (Zhuge Liang Safe & Ass-wiping Protocol)

[English](#english) | [中文](#chinese)

<a name="english"></a>
## 💡 English Introduction
An intelligent, cross-platform auto-proxy monitoring script with **"Pre-flight Zhuge Liang Diagnostics"** and **"Post-crash Ass-Wiping Rollbacks"**, designed specifically for the **OpenClaw Gateway**.


### ❓ Why do you need this?
If you are running the OpenClaw Gateway on your Mac/Linux, you might have noticed an annoying problem:
- **The zombie gateway**: Sometimes the Node.js process stays alive in the background, but the gateway fails to connect to Telegram or hangs silently.
- **The VPN issue**: If you use a VPN or switch between direct connection and proxy (TUN/HTTP), the Telegram API connection gets lost and OpenClaw refuses to seamlessly reconnect unless you manually edit configurations and restart it.

**This watchdog fixes all of that.** It performs a true "Layer-7 Application Health Check" instead of just looking if the process is running. Plus, it dynamically tests network routing and alters your OpenClaw proxy settings on the fly so you NEVER drop a message again.

### 🚀 Key Features vs. Competitors
Unlike basic process watchers that just verify if `node.exe` is running:
1. **Intelligent Network Sniffer**: Capable of dynamically adjusting OpenClaw's proxy routing configuration. The script periodically validates Telegram API reachability using both direct traffic and predefined local proxy tunnels, seamlessly hot-swapping routing strategies without user intervention.
2. **Layer 7 Application Health Checks**: Monitors the internal OpenClaw `http://127.0.0.1:18789/health` endpoint, identifying locked or zombie processes long before a system crash occurs.
3. **Config Guardian & Rollback (v1.1.0)**: Automatically snaps a backup of `openclaw.json` when the gateway is healthy. If a Telegram Bot accidentally modifies the config with invalid syntax, the watchdog will detect the corruption, delete the invalid config, restore the last known-good snapshot, and safely kickstart the application.
4. **Safe-Restart Protocol (v1.2.0)**: Includes `safe-restart.sh` and a strict AI Skill Directive (`SKILL.md`). This guarantees that your Telegram assistant validates its own JSON syntax errors BEFORE restarting the gateway, preventing accidental suicide disconnections.
5. **Optimized macOS Launch Daemon Integration**: Refines standard `<string>ThrottleInterval</string>` to prevent system launchd abandonment during consecutive internal reboots.

### 📦 Installation
#### For macOS/Linux (Recommended)
You can directly execute the one-click installer:
```bash
git clone https://github.com/iamwilliamzhuo-source/openclaw-watchdog.git
cd openclaw-watchdog
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
1. **独创的内置自适应代理引擎 (Smart Auto-Proxy)**: 你可能有时挂着全局 TUN VPN，有时只开 HTTP 代理。该探针每 60 秒并行测试 Telegram API 直连测速和代理测速。当直连通畅时自动从 OpenClaw 配置文件中抹除旧代理路由；代理可用时则瞬时配置上默认的 `127.0.0.1:7897` 并触发静默重启。
2. **真正的 Layer 7 检测**: 许多守护程序只要看见 `node` 进程在苟延残喘就不会干预。本库深度调用网关的底层 `/health` REST API，专杀一切“死锁、卡资源、无响应但未退出”的僵尸状态进程，毫不留情直接触发 `launchctl kickstart` 热部署接客！
3. 🧻 **事后擦屁股：配置自愈快照 (Config Guardian v1.1.0)**: **[最新功能]** 当机器人自己把自己的 `openclaw.json` 写坏导致网关无限崩溃时，普通看门狗会陷入无限重启的死循环。我们的守护程序每分钟验证并在健康时自动保存 `openclaw.json.watchdog_bak` 快照。当检测到网关因为配置文件破损而报错时，看门狗会直接抹除错乱的配置，将前一分钟健康的祖传快照覆盖回去，然后热重启强行复活机器帮你擦好最后一次危险操作的屁股！
> ⚠️ 注意：此机制意味着如果你的错误修改导致了网关崩溃，你的修改将被看门狗无情抹杀并恢复到上个状态。
4. 🧙‍♂️ **事前诸葛亮：防自杀保护闭环 (Safe-Restart v1.2.0)**: 为 AI 机器人植入硬性技能指令手册，强行拦截 AI 直接用危险命令重启网关导致断线。要求系统重启前，必须由这位“事前诸葛亮”通过 `safe-restart.sh` 做一次包含报错拦截机制的语法体检。
5. **原生无感 Cron/Daemon 融合机制**: macOS 原汁原味系统级提权，防抛弃参数优化，几乎不产生内存侵占。

### 📦 安装方式
#### 苹果 Mac (主力平台)
建议通过以下一行式安装直接布防防线及定时器：
```bash
git clone https://github.com/iamwilliamzhuo-source/openclaw-watchdog.git
cd openclaw-watchdog
/bin/bash scripts/install-mac.sh
```

#### Windows (探索版)
你可以利用 Windows 系统自带的任务计划程序定时调度 `scripts/watchdog-win.ps1` 脚本，它同样具备 Layer 7 HTTP 级别的监测纠错能力。

---

## 📜 许可证 (License)
基于 MIT 开源协议构建。
