#!/bin/bash

sketchybar --add item time right \
           --set time icon= \
                          label="$(date +"%I:%M %p")" \
                          update_freq=30 \
                          script="$PLUGIN_DIR/time.sh"
