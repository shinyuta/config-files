#!/bin/bash

sketchybar --add item media center \
           --set media label.color=$DIM \
                       label.max_chars=20 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon=󰎆 \
                       icon.font="JetBrainsMono Nerd Font:Regular:19.0" \
                       icon.color=$DIM \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
                       update_freq=5 \
           --subscribe media media_change
