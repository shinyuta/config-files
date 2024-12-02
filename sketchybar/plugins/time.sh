#!/bin/bash
source "$CONFIG_DIR/colors.sh"

sketchybar --set $NAME label="$(date +"%I:%M %p")" \
                       label.color=$ACCENT_COLOR \
                       icon.color=$ACCENT_COLOR \
                       background.drawing=off 


