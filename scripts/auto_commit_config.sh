#!/bin/zsh

# Define repository path
CONFIG_DIR="$HOME/.config"
LOG_FILE="$HOME/Desktop/scripts/auto_commit_config.log"
> "$LOG_FILE"

cd "$CONFIG_DIR" || { echo "Failed to access $CONFIG_DIR"; exit 1; }

echo "==== Auto Commit Config - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Check if the directory is a Git repository
if [ ! -d "$CONFIG_DIR/.git" ]; then
    echo "Error: ~/.config is not a Git repository!" | tee -a "$LOG_FILE"
    exit 1
fi

# Fetch latest changes
git fetch origin | tee -a "$LOG_FILE"

# Check if there are any incoming changes
if [[ $(git status -uno | grep "Your branch is behind") ]]; then
    echo "Remote changes detected! Skipping auto-commit to prevent conflicts." | tee -a "$LOG_FILE"
    exit 0
fi

# Check for local changes
CHANGED_DIRS=$(git status --short | awk '{print $2}' | cut -d'/' -f1 | sort -u)

if [[ -z "$CHANGED_DIRS" ]]; then
    echo "No changes detected, exiting..." | tee -a "$LOG_FILE"
    exit 0
fi

# Stage all changes
git add . | tee -a "$LOG_FILE"

# Construct commit message with changed directories
COMMIT_MESSAGE="Updated configs: $(echo $CHANGED_DIRS | tr '\n' ' ')"
echo "Committing changes: $COMMIT_MESSAGE" | tee -a "$LOG_FILE"

git commit -m "$COMMIT_MESSAGE" | tee -a "$LOG_FILE"

# Push changes
git push origin main | tee -a "$LOG_FILE"

echo "Auto commit and push complete!" | tee -a "$LOG_FILE"
