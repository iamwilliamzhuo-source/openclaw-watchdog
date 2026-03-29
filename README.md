# OpenClaw Sentinel

[English](#english) | [中文](#chinese)

<a name="english"></a>
## 💡 English Introduction
An intelligent, cross-platform auto-proxy monitoring script designed specifically for the **OpenClaw Gateway**. Keep your bot gateway connection resilient in dynamic network environments through an innovative "Layer 7 PING Mechanism."

### 🚀 Key Features vs. Competitors
Unlike basic process watchers that just verify if `node.exe` is running:
1. **Intelligent Network Sniffer**: Capable of dynamically adjusting OpenClaw's proxy routing configuration. The script periodically validates Telegram API reachability using both direct traffic and predefined local proxy tunnels, seamlessly hot-swapping routing strategies without user intervention.
2. **Layer 7 Application Health Checks**: Monitors the internal OpenClaw `http://127.0.0.1:18789/health` endpoint, identifying locked or zombie processes long before a system crash occurs.
3. **Optimized macOS Launch Daemon Integration**: Refines standard `<string>ThrottleInterval</string>` to prevent system launchd abandonment during consecutive internal reboots.

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
一个专注于为 **OpenClaw 网关** 定制的“智能自适应代理”级别的看门狗与高可用防线工具。作者：**William Zhuo**。
这套代码旨在深度解决频繁断网、以及不同网络翻墙情境下的代理失效僵死问题。

### 🚀 杀手级特性
较目前开源社区的常规方案，本项目采用了真正的“智能应用层防线”：
1. **独创的内置自适应代理引擎 (Smart Auto-Proxy)**: 你可能有时挂着全局 TUN VPN，有时只开 HTTP 代理。该探针每 60 秒并行测试 Telegram API 直连测速和代理测速。当直连通畅时自动从 OpenClaw 配置文件中抹除旧代理路由；代理可用时则瞬时配置上默认的 `127.0.0.1:7897` 并触发静默重启。
2. **真正的 Layer 7 检测**: 许多守护程序只要看见 `node` 进程在苟延残喘就不会干预。本库深度调用网关的底层 `/health` REST API，专杀一切“死锁、卡资源、无响应但未退出”的僵尸状态进程，毫不留情直接触发 `launchctl kickstart` 热部署接客！
3. **原生无感 Cron/Daemon 融合机制**: macOS 原汁原味系统级提权，防抛弃参数优化，几乎不产生内存侵占。

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
