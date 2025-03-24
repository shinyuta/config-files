#!/bin/zsh

# Empty log file before starting
LOG_FILE=~/Desktop/scripts/reload_config.log
> "$LOG_FILE"

echo "==== Reloading Configs - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Reload SketchyBar
echo "Reloading SketchyBar..." | tee -a "$LOG_FILE"
sketchybar --reload | tee -a "$LOG_FILE"

# Reload Aerospace
echo "Reloading Aerospace..." | tee -a "$LOG_FILE"
aerospace reload-config | tee -a "$LOG_FILE"

echo "Config reload complete!" | tee -a "$LOG_FILE"
