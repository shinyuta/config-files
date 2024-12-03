#!/bin/bash
# change icon.color and label.color to full opacity
sketchybar --add item front_app left \
           --set front_app       background.color=$BLUE \
                                 icon.color=0xff100f14 \
                                 icon.font="sketchybar-app-font:Regular:16.0" \
                                 label.color=0xff100f14 \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
