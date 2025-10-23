#!/bin/bash
# change icon.color and label.color to full opacity
sketchybar --add item front_app left \
  --set front_app background.color=$WHITE \
  icon.color=$DIM \
  icon.font="sketchybar-app-font:Regular:16.0" \
  label.color=$DIM \
  script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched
