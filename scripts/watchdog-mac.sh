#!/bin/bash
# -------------------------------------------------------------------------------------
# OpenClaw Smart Watchdog (macOS/Linux)
# A Layer 7 health monitor with Smart Auto-Proxy routing capabilities.
# -------------------------------------------------------------------------------------

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# User Configurations
PROXY_URL=${PROXY_URL:-"http://127.0.0.1:7897"}  # Your default proxy endpoint
GATEWAY_PORT=${GATEWAY_PORT:-"18789"}            # Your OpenClaw Gateway port
HEALTH_URL="http://127.0.0.1:$GATEWAY_PORT/health"
API_URL="https://api.telegram.org"
LOG_DIR="$HOME/.openclaw/logs"
LOG_FILE="$LOG_DIR/watchdog.log"
LAUNCHD_LABEL="gui/$(id -u)/ai.openclaw.gateway"

# Ensure dir exists
mkdir -p "$LOG_DIR"

TIMESTAMP=$([ -x "$(command -v gdate)" ] && gdate "+%Y-%m-%d %H:%M:%S" 2>/dev/null || date "+%Y-%m-%d %H:%M:%S")

# 1. Probe current OpenClaw config
CURRENT_PROXY=$(openclaw config get channels.telegram.proxy 2>/dev/null | grep -o "http://[a-zA-Z0-9.:]*" | head -n 1)

# 2. Probe Network Status
curl -s --connect-timeout 2 "$API_URL" > /dev/null
DIRECT_STATUS=$?

curl -x "$PROXY_URL" -s --connect-timeout 2 "$API_URL" > /dev/null
PROXY_STATUS=$?

CONFIG_CHANGED=0

# 3. Smart Proxy Routing Engine
if [ $DIRECT_STATUS -eq 0 ]; then
    # Direct network is available (e.g. global VPN active or clean network)
    if [ -n "$CURRENT_PROXY" ]; then
        echo "[$TIMESTAMP] Network Direct OK. Removing outdated Proxy config..." >> "$LOG_FILE"
        openclaw config unset channels.telegram.proxy >/dev/null 2>&1
        CONFIG_CHANGED=1
    fi
elif [ $PROXY_STATUS -eq 0 ]; then
    # Must use proxy to reach API
    if [ -z "$CURRENT_PROXY" ] || [ "$CURRENT_PROXY" != "$PROXY_URL" ]; then
        echo "[$TIMESTAMP] Network Direct FAILED. Proxy OK. Setting Proxy config to $PROXY_URL..." >> "$LOG_FILE"
        openclaw config set channels.telegram.proxy "$PROXY_URL" >/dev/null 2>&1
        CONFIG_CHANGED=1
    fi
else
    # Completely offline
    echo "[$TIMESTAMP] NETWORK OFFLINE: Both Direct and Proxy failed." >> "$LOG_FILE"
fi

# 4. Restart if config changed
if [ $CONFIG_CHANGED -eq 1 ]; then
    echo "[$TIMESTAMP] Config swapped. Initiating Gateway soft kickstart..." >> "$LOG_FILE"
    # Wait for config to flush
    sleep 1
    launchctl kickstart -k "$LAUNCHD_LABEL" >/dev/null 2>&1
    exit 0
fi

# 5. Application Layer Health Check
HTTP_STATUS=$(curl -s --connect-timeout 5 -o /dev/null -w "%{http_code}" "$HEALTH_URL")
if [ "$HTTP_STATUS" -ne 200 ]; then
    echo "[$TIMESTAMP] Gateway health check failed (HTTP $HTTP_STATUS). Initiating hard restart." >> "$LOG_FILE"
    launchctl kickstart -k "$LAUNCHD_LABEL" >/dev/null 2>&1
fi
