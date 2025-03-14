#!/bin/bash

sketchybar --add item media center \
           --set media label.color=$ACCENT_COLOR \
                       label.max_chars=20 \
                       icon.padding_left=0 \
                       scroll_texts=on \
                       icon=󰎆 \
                       icon.font="JetBrainsMono Nerd Font:Regular:19.0" \
                       icon.color=$ACCENT_COLOR \
                       background.drawing=off \
                       script="$PLUGIN_DIR/media.sh" \
                       click_script="$PLUGIN_DIR/media_pause.sh" \
           --subscribe media media_change mouse.clicked
