#!/bin/bash
# Install Smart Proxy Watchdog for OpenClaw Gateway (macOS)

echo "🐾 Installing OpenClaw Smart Watchdog for Mac..."

# Ensure target directories exist
TARGET_DIR="$HOME/.openclaw/bin"
SKILL_DIR="$HOME/.openclaw/workspace/skills/bot-safe-protocol"

mkdir -p "$TARGET_DIR"
mkdir -p "$SKILL_DIR"

# Copy scripts and SKILL models
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
REPO_DIR="$(dirname "$CURRENT_DIR")"

cp "$CURRENT_DIR/watchdog-mac.sh" "$TARGET_DIR/watchdog.sh"
cp "$CURRENT_DIR/safe-restart.sh" "$TARGET_DIR/safe-restart.sh"
chmod +x "$TARGET_DIR/watchdog.sh" "$TARGET_DIR/safe-restart.sh"

cp "$REPO_DIR/skills/bot-safe-protocol/SKILL.md" "$SKILL_DIR/SKILL.md"

echo "✅ Scripts deployed to $TARGET_DIR / Bot Skill deployed to $SKILL_DIR"

# Enable cron job
CRON_PAYLOAD="* * * * * $TARGET_DIR/watchdog.sh"
(crontab -l 2>/dev/null | grep -v "watchdog.sh"; echo "$CRON_PAYLOAD") | crontab -

echo "✅ Cron-based minute guardian enabled."

# Update LaunchAgent if it exists
PLIST_PATH="$HOME/Library/LaunchAgents/ai.openclaw.gateway.plist"
if [ -f "$PLIST_PATH" ]; then
    echo "⚙️  Optimizing OpenClaw LaunchDaemon..."
    # Increase the ThrottleInterval from 1 to 10 manually if feasible
    /usr/libexec/PlistBuddy -c "Set :ThrottleInterval 10" "$PLIST_PATH" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :ThrottleInterval integer 10" "$PLIST_PATH" 2>/dev/null
    
    /usr/libexec/PlistBuddy -c "Set :ProcessType Background" "$PLIST_PATH" 2>/dev/null || \
    /usr/libexec/PlistBuddy -c "Add :ProcessType string Background" "$PLIST_PATH" 2>/dev/null
    
    launchctl unload "$PLIST_PATH" 2>/dev/null
    launchctl load -w "$PLIST_PATH" 2>/dev/null
    echo "✅ LaunchAgent updated and reloaded with resilient bounds."
fi

echo "🚀 Installation Complete! Your Gateway is now self-healing."
