#!/bin/bash

# Subscribe all items to mouse.clicked so we can close the popup if user clicks elsewhere
sketchybar --subscribe "/.*/" mouse.clicked

# Clean up old references
sketchybar --remove time 2>/dev/null
sketchybar --remove time.popup 2>/dev/null
sketchybar --remove time.weather 2>/dev/null

# 1) Add the "time" item on the LEFT side
sketchybar --add item time left

sketchybar --set time \
  icon="󰥔" \
  label="$(date +'%I:%M %p')" \
  label.color="$DIM" \
  icon.color="$DIM" \
  update_freq=30 \
  script="$PLUGIN_DIR/time.sh" \
  background.drawing=off \
  background.color=0x00000000 \
  popup.background.corner_radius=8 \
  popup.background.color=0xcc000000 \
  popup.drawing=off \
  popup.y_offset=-20 \
  y_offset=0
