#!/bin/bash

sketchybar --add item volume right

sketchybar --set volume \
  script="$PLUGIN_DIR/volume.sh" \
  scrollable=on \
  scroll.update=on \
  background.drawing=off

sketchybar --subscribe volume volume_change mouse.scrolled
