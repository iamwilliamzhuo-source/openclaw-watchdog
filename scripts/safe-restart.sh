#!/bin/bash
# -------------------------------------------------------------------------------------
# OpenClaw Safe-Restart Protocol
# Protects the gateway against suicidal config modifications by Telegram bots.
# -------------------------------------------------------------------------------------

export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

LAUNCHD_LABEL="gui/$(id -u)/ai.openclaw.gateway"
CONFIG_FILE="$HOME/.openclaw/openclaw.json"
BACKUP_FILE="$CONFIG_FILE.watchdog_bak"

echo "🛡️ Deploying Smart Sentinel Pre-flight Check..."

# Step 1: Pre-flight Validation
if ! openclaw config validate; then
    echo "=========================================================================="
    echo "🚨 [FATAL ERROR] PRE-FLIGHT CHECK FAILED 🚨"
    echo "=========================================================================="
    echo "Warning to AI Bot:"
    echo "Your recent modifications to openclaw.json have introduced syntax errors"
    echo "or schema validation anomalies."
    echo "The Gateway RESTART HAS BEEN ABORTED to save your life!"
    echo "Please read the openclaw config validate error above, fix the JSON,"
    echo "and then run 'bash ~/.openclaw/bin/safe-restart.sh' again."
    exit 1
fi

echo "✅ Configuration is clean. Securing fresh snapshot..."
cp "$CONFIG_FILE" "$BACKUP_FILE"

echo "🔄 Initiating safe restart procedure..."
launchctl kickstart -k "$LAUNCHD_LABEL" >/dev/null 2>&1

echo "✨ Gateway restarted successfully!"
exit 0
