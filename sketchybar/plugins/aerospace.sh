#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/colors.sh" # Ensure colors are properly sourced

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME \
    label.color=$WHITE \  # Active color
  background.color=$BAR_COLOR
else
  sketchybar --set $NAME \
    label.color=$DIM \  # Inactive color
fi
