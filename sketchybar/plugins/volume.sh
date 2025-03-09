#!/bin/sh
source "$CONFIG_DIR/colors.sh"

case "$SENDER" in
  "volume_change")
    VOLUME="$INFO"
    ;;
  "mouse.scrolled")
    currentVolume=$(osascript -e "output volume of (get volume settings)")

    if [ "$SCROLL_DELTA" -gt 0 ]; then
      # Positive delta => user scrolled UP => raise volume
      VOLUME=$(( currentVolume + 5 ))
    else
      # Negative delta => user scrolled DOWN => lower volume
      VOLUME=$(( currentVolume - 5 ))
    fi

    osascript -e "set volume output volume $VOLUME"
    ;;
esac

# If VOLUME is empty, fallback to current system volume
[ -z "$VOLUME" ] && VOLUME=$(osascript -e "output volume of (get volume settings)")

# Pick the icon
case "$VOLUME" in
  [6-9][0-9]|100) ICON="󰕾" ;;
  [3-5][0-9])     ICON="󰖀" ;;
  [1-9]|[1-2][0-9]) ICON="󰕿" ;;
  *)              ICON="󰖁" ;;
esac

# Format the volume as triple digits (e.g., 007, 030, 100)
TRIPLE_VOL=$(printf "%03d" "$VOLUME")

# Update SketchyBar with the triple-digit label
sketchybar --set "$NAME" \
  icon="$ICON" \
  label="${TRIPLE_VOL}%" \
  label.color="$DIM" \
  icon.color="$DIM"
