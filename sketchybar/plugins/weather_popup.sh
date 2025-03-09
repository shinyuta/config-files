#!/bin/bash
source "$CONFIG_DIR/colors.sh"

# Example: quick text forecast from wttr.in
# This returns a one-line summary, e.g., "⛅️ +15°C"
WEATHER="$(curl -s 'wttr.in/55118?format=%C+%t&u')"

# If you want a more detailed line, you can experiment with '?format=2' or other formats:
# https://github.com/chubin/wttr.in#one-line-output

# Set the label to the weather string
sketchybar --set "$NAME" \
  label="$WEATHER" \
  label.color="$ACCENT_COLOR" \
  icon.color="$ACCENT_COLOR"
