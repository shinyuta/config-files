#!/bin/bash
source "$CONFIG_DIR/colors.sh"

# Add the main network item on the right side
sketchybar --add item net.speed right

# Configure net.speed
sketchybar --set net.speed \
  script="$PLUGIN_DIR/net.sh" \
  update_freq=3 \
  label="↑ 0.00MiB/s ↓ 0.00MiB/s" \
  label.color="$DIM" \
  icon.color="$DIM" \
  background.drawing=off \
  popup.background.corner_radius=8 \
  popup.background.color=0xcc000000 \
  popup.y_offset=0 \
  popup.drawing=off

# Subscribe net.speed to mouse events (for popup toggling)
sketchybar --subscribe net.speed mouse.clicked mouse.exited.global

# Add a popup child for total usage
sketchybar --add item net.totals popup.net.speed
sketchybar --set net.totals \
  script="$PLUGIN_DIR/net.sh" \
  label="..." \
  label.color="$DIM" \
  icon.color="$DIM" \
  background.drawing=off \
  label.padding_left=6 \
  label.padding_right=6
