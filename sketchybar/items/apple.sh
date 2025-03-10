#!/bin/bash

# 1) Subscribe all items to mouse.clicked, so we can detect clicks on anything else
sketchybar --subscribe "/.*/" mouse.clicked

# 2) Add the Apple logo on the LEFT side
sketchybar --add item apple.logo left

# 3) Configure the Apple logo with reduced padding
sketchybar --set apple.logo \
  icon="" \
  icon.color=0xffffffff \
  icon.font="JetBrainsMono Nerd Font:Regular:16.0" \
  background.drawing=off \
  script="$PLUGIN_DIR/apple.sh" \
  popup.background.corner_radius=8 \
  popup.background.color=0xcc000000 \
  popup.y_offset=0 \
  popup.drawing=off \
  label.padding_left=4 \
  label.padding_right=0

# 4) Subscribe apple.logo to mouse.clicked + mouse.exited.global
sketchybar --subscribe apple.logo mouse.clicked mouse.exited.global

# 5) Add “Preferences” item
sketchybar --add item apple.preferences popup.apple.logo
sketchybar --set apple.preferences \
  script="$PLUGIN_DIR/apple.sh" \
  icon="" \
  label="Preferences" \
  background.drawing=off \
  icon.color=0xffffffff \
  label.color=0xffffffff \
  label.padding_left=6 \
  label.padding_right=6
sketchybar --subscribe apple.preferences mouse.clicked

# 6) Add “Lock Screen” item
sketchybar --add item apple.lock popup.apple.logo
sketchybar --set apple.lock \
  script="$PLUGIN_DIR/apple.sh" \
  icon="" \
  label="Lock Screen" \
  background.drawing=off \
  icon.color=0xffffffff \
  label.color=0xffffffff \
  label.padding_left=6 \
  label.padding_right=6
sketchybar --subscribe apple.lock mouse.clicked

# 7) Add “Reload” item
sketchybar --add item apple.reload popup.apple.logo
sketchybar --set apple.reload \
  script="$PLUGIN_DIR/apple.sh" \
  icon="" \
  label="Reload" \
  background.drawing=off \
  icon.color=0xffffffff \
  label.color=0xffffffff \
  label.padding_left=6 \
  label.padding_right=6
sketchybar --subscribe apple.reload mouse.clicked
