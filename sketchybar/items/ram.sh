#!/bin/bash
# Creates a text item in SketchyBar to show "Available" memory as a percentage,
# updated every 3 seconds.

source "$CONFIG_DIR/colors.sh"

# Add the RAM item on the right side of the bar
sketchybar --add item ram_avail right

# Configure it
sketchybar --set ram_avail \
  icon= \
  script="$PLUGIN_DIR/ram.sh" \
  update_freq=2 \
  label="---%" \
  label.color="$DIM" \
  background.drawing=off
