#!/bin/bash
source "$CONFIG_DIR/colors.sh"

sketchybar --set "$NAME" \
  label="$(date +'%a %b %d')" \
  label.color="$DIM" \
  icon.color="$DIM"
