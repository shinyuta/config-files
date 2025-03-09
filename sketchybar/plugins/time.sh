#!/bin/bash
source "$CONFIG_DIR/colors.sh"

POPUP_ITEM="time"

close_popup_animate() {
  sketchybar --animate sin 20 --set "$POPUP_ITEM" \
    popup.background.color=0x00000000

  sketchybar --animate sin 20 --set time.popup \
    label.color=0x00ffffff \
    icon.color=0x00ffffff

  sketchybar --animate sin 20 --set time.weather \
    label.color=0x00ffffff \
    icon.color=0x00ffffff

  sleep 0.33

  sketchybar --set "$POPUP_ITEM" \
    popup.drawing=off \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000

  sketchybar --set time.popup \
    label.color="$ACCENT_COLOR" \
    icon.color="$ACCENT_COLOR"

  sketchybar --set time.weather \
    label.color="$ACCENT_COLOR" \
    icon.color="$ACCENT_COLOR"
}

open_popup_animate() {
  # 1) Update the weather item before showing the popup
  sketchybar --update time.weather

  # 2) Start above, black background
  sketchybar --set "$POPUP_ITEM" \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000 \
    popup.drawing=on

  # 3) Slide down
  sketchybar --animate sin 10 --set "$POPUP_ITEM" popup.y_offset=0

  # 4) Ensure child label/icon are pink
  sketchybar --set time.popup label.color="$ACCENT_COLOR" icon.color="$ACCENT_COLOR"
  sketchybar --set time.weather label.color="$ACCENT_COLOR" icon.color="$ACCENT_COLOR"
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
    # Update the main time label every 30s
    sketchybar --set "$NAME" \
      label="$(date +'%I:%M %p')" \
      label.color="$ACCENT_COLOR" \
      icon.color="$ACCENT_COLOR"
    ;;
esac
