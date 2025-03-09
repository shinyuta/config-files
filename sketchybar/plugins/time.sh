#!/bin/bash
source "$CONFIG_DIR/colors.sh"

POPUP_ITEM="time"

close_popup_animate() {
  # 1) Fade the parent popup background from black to transparent
  sketchybar --animate sin 20 --set "$POPUP_ITEM" \
    popup.background.color=0x00000000

  # 2) Fade both the label and icon to transparent
  sketchybar --animate sin 20 --set time.popup \
    label.color=0x00ffffff \
    icon.color=0x00ffffff

  # 3) Wait ~0.33s
  sleep 0.33

  # 4) Hide the popup, reset offset & background
  sketchybar --set "$POPUP_ITEM" \
    popup.drawing=off \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000

  # 5) Reset child label & icon color
  sketchybar --set time.popup \
    label.color="$ACCENT_COLOR" \
    icon.color="$ACCENT_COLOR"
}

open_popup_animate() {
  # Start above, black background
  sketchybar --set "$POPUP_ITEM" \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000 \
    popup.drawing=on

  # Slide down
  sketchybar --animate sin 10 --set "$POPUP_ITEM" popup.y_offset=0

  # Ensure child label is pink
  sketchybar --set time.popup label.color="$ACCENT_COLOR"
}

toggle_popup() {
  local IS_OPEN
  IS_OPEN=$(sketchybar --query "$POPUP_ITEM" | grep -c "popup.drawing=on")

  if [ "$IS_OPEN" -eq 0 ]; then
    open_popup_animate
  else
    close_popup_animate
  fi
}

case "$SENDER" in
  "mouse.clicked")
    if [ "$NAME" = "time" ]; then
      toggle_popup
    else
      close_popup_animate
    fi
    ;;
  "mouse.exited.global")
    if [ "$NAME" = "time" ]; then
      close_popup_animate
    fi
    ;;
  "routine")
    # Update the main time label (HH:MM PM) in pink every 30s
    sketchybar --set "$NAME" \
      label="$(date +'%I:%M %p')" \
      label.color="$ACCENT_COLOR" \
      icon.color="$ACCENT_COLOR"
    ;;
esac
