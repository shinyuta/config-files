#!/bin/bash

# Subscribe all items to mouse.clicked so we can close the popup if user clicks elsewhere
sketchybar --subscribe "/.*/" mouse.clicked

# Clean up old references (optional)
sketchybar --remove time 2>/dev/null
sketchybar --remove time.popup 2>/dev/null

# 1) Add the "time" item on the LEFT side
sketchybar --add item time left

sketchybar --set time \
  icon="󰥔" \
  label="$(date +'%I:%M %p')" \
  label.color="$ACCENT_COLOR" \
  icon.color="$ACCENT_COLOR" \
  update_freq=30 \
  script="$PLUGIN_DIR/time.sh" \
  background.drawing=off \
  background.color=0x00000000 \
  popup.background.corner_radius=8 \
  popup.background.color=0xcc000000 \
  popup.drawing=off \
  popup.y_offset=-20 \
  y_offset=-1

sketchybar --subscribe time mouse.clicked mouse.exited.global

# 2) Add the popup child item "time.popup"
sketchybar --add item time.popup popup.time

sketchybar --set time.popup \
  icon="󰃭" \
  icon.drawing=on \
  label="$(date +'%a %b %d')" \
  script="$PLUGIN_DIR/time_popup.sh" \
  background.drawing=off \
  background.color=0x00000000 \
  update_freq=3600

# If you want the date to auto-refresh every hour
sketchybar --subscribe time.popup routine
