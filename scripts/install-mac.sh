#!/bin/bash
# Install Smart Proxy Watchdog for OpenClaw Gateway (macOS)

echo "🐾 Installing OpenClaw Smart Watchdog for Mac..."

# Ensure target directories exist
TARGET_DIR="$HOME/.openclaw/bin"
mkdir -p "$TARGET_DIR"

# Copy the script
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cp "$CURRENT_DIR/watchdog-mac.sh" "$TARGET_DIR/watchdog.sh"
chmod +x "$TARGET_DIR/watchdog.sh"

echo "✅ Watchdog script deployed to $TARGET_DIR/watchdog.sh"

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
