#!/bin/bash

# Log file for debugging (optional)
LOG_FILE="$HOME/.config/sketchybar/media_pause.log"

echo "$(date): Media pause script started" >> "$LOG_FILE"

# Send Play/Pause key via Hammerspoon
osascript -e 'tell application "Hammerspoon" to execute lua code "hs.eventtap.event.newSystemKeyEvent(\"PLAY\", true):post(); hs.eventtap.event.newSystemKeyEvent(\"PLAY\", false):post()"'

echo "$(date): Sent Play/Pause key via Hammerspoon" >> "$LOG_FILE"

# Hide media item from SketchyBar after pausing
sketchybar --set media drawing=off

echo "$(date): SketchyBar media hidden" >> "$LOG_FILE"
