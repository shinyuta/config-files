#!/bin/zsh

# Load environment from .zshrc
source ~/.zshrc

# Empty the log file before writing new logs
> ~/Desktop/scripts/macos_maintenance.log

echo "==== macOS Maintenance Log - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Set PATH explicitly (just in case)
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

LOG_FILE=~/Desktop/scripts/macos_maintenance.log

echo "Starting macOS Maintenance..." | tee -a "$LOG_FILE"

# 1. Update Homebrew and cleanup
echo "Updating Homebrew..." | tee -a "$LOG_FILE"
brew update && brew upgrade && brew cleanup | tee -a "$LOG_FILE"

# 2. Update Mac App Store apps
echo "Updating Mac App Store apps..." | tee -a "$LOG_FILE"
if command -v mas &>/dev/null; then
    mas upgrade | tee -a "$LOG_FILE"
else
    echo "mas command not found. Install it with: brew install mas" | tee -a "$LOG_FILE"
fi

# 3. Clear caches without sudo
echo "Cleaning system caches..." | tee -a "$LOG_FILE"
rm -rf ~/Library/Caches/*
rm -rf ~/Library/Logs/*

# 4. Purge inactive memory using launchctl
echo "Purging inactive memory..." | tee -a "$LOG_FILE"
launchctl kickstart -k system/com.apple.dynamic_pager

# 5. Flush DNS cache
echo "Flushing DNS cache..." | tee -a "$LOG_FILE"
sudo -S dscacheutil -flushcache <<< "" 2>/dev/null
sudo -S killall -HUP mDNSResponder <<< "" 2>/dev/null

# 6. Restart Dock and Finder
echo "Restarting Dock and Finder..." | tee -a "$LOG_FILE"
killall Dock Finder

# 7. Check disk usage
echo "Checking disk space..." | tee -a "$LOG_FILE"
df -h | tee -a "$LOG_FILE"

# 8. Verify disk health
echo "Verifying disk health..." | tee -a "$LOG_FILE"
diskutil verifyVolume / | tee -a "$LOG_FILE"

echo "macOS Maintenance Complete!" | tee -a "$LOG_FILE"
