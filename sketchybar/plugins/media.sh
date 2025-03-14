#!/bin/bash

source "$CONFIG_DIR/colors.sh" # Load color variables

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"
  APP="$(echo "$INFO" | jq -r '.app')"

  if [[ "$APP" == "Spotify" ]]; then
    COLOR=$GREEN   # Spotify → Green
    ICON="󰎆"       # Spotify icon
  else
    COLOR=$ACCENT_COLOR  # Default color for non-Spotify media
    ICON=""           # Non-Spotify media icon
  fi

  sketchybar --set $NAME label="$MEDIA" label.color=$COLOR icon="$ICON" icon.color=$COLOR drawing=on
else
  sketchybar --set $NAME drawing=off
fi
