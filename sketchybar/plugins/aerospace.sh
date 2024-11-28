#!/bin/bash

CONFIG_DIR="$HOME/.config/sketchybar"
source "$CONFIG_DIR/colors.sh" # Ensure colors are properly sourced

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME \
        label.color=0xffe0def4 \  # Active color
        background.color=$BAR_COLOR
else
    sketchybar --set $NAME \
        label.color=0xff575279 \  # Inactive color
fi
