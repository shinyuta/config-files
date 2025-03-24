#!/bin/zsh

# Empty log file before starting
LOG_FILE=~/Desktop/scripts/cleanup_storage.log
> "$LOG_FILE"

echo "==== Storage Cleanup Log - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# 1️⃣ Delete system caches & logs
echo "Deleting system caches and logs..." | tee -a "$LOG_FILE"
rm -rf ~/Library/Caches/* ~/Library/Logs/*
sudo rm -rf /Library/Caches/* /Library/Logs/*

# 2️⃣ Clear old Xcode archives & derived data
if [[ -d "$HOME/Library/Developer/Xcode" ]]; then
    echo "Clearing old Xcode archives and derived data..." | tee -a "$LOG_FILE"
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    rm -rf ~/Library/Developer/Xcode/Archives/*
else
    echo "Xcode directory not found, skipping cleanup." | tee -a "$LOG_FILE"
fi

# 3️⃣ List large files (over 500MB) for review
echo "Listing large files (>500MB) in Home directory..." | tee -a "$LOG_FILE"
find ~ -type f -size +500M -exec ls -lh {} + | awk '{ print $9 ": " $5 }' | tee -a "$LOG_FILE"

echo "Storage Cleanup Completed!" | tee -a "$LOG_FILE"
