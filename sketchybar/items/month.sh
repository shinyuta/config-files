#!/bin/bash

sketchybar --add item month left \
           --set month icon=󰃭 \
                          label="$(date +'%a %b %d')" \
                          update_freq=30 \
                          script="$PLUGIN_DIR/month.sh"
