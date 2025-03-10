#!/bin/bash
source "$CONFIG_DIR/colors.sh"

POPUP_ITEM="apple.logo"

close_popup_animate() {
  ########################################################################
  # Step A: Ensure the parent's popup background is opaque first
  ########################################################################
  sketchybar --set "$POPUP_ITEM" \
    popup.background.color=0xcc000000

  ########################################################################
  # Step B: Ensure child items (preferences, lock, reload) are fully visible
  ########################################################################
  for child in apple.preferences apple.lock apple.reload; do
    sketchybar --set "$child" \
      icon.color=0xffffffff \
      label.color=0xffffffff
  done

  ########################################################################
  # Step C: Animate the parent's popup background to transparent
  ########################################################################
  sketchybar --animate sin 20 --set "$POPUP_ITEM" \
    popup.background.color=0x00000000

  ########################################################################
  # Step D: Animate the child items' icon/label color to transparent
  ########################################################################
  for child in apple.preferences apple.lock apple.reload; do
    sketchybar --animate sin 20 --set "$child" \
      icon.color=0x00ffffff \
      label.color=0x00ffffff
  done

  ########################################################################
  # Step E: Wait ~0.33s for both animations to finish
  ########################################################################
  sleep 0.33

  ########################################################################
  # Step F: Hide the popup entirely, resetting offsets and colors
  ########################################################################
  sketchybar --set "$POPUP_ITEM" \
    popup.drawing=off \
    popup.y_offset=0 \
    popup.background.color=0xcc000000

  for child in apple.preferences apple.lock apple.reload; do
    sketchybar --set "$child" \
      icon.color=0xffffffff \
      label.color=0xffffffff
  done
}

# 2) Slide-down animation to open
open_popup_animate() {
  # Start hidden, above the item, fully opaque background
  sketchybar --set "$POPUP_ITEM" \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000 \
    popup.drawing=on

  # Animate downward to y_offset=0
  sketchybar --animate sin 10 --set "$POPUP_ITEM" popup.y_offset=0
}

toggle_popup() {
  local IS_OPEN
  IS_OPEN=$(sketchybar --query "$POPUP_ITEM" | grep -c "popup.drawing=on")

  if [ "$IS_OPEN" -eq 0 ]; then
    # Popup is closed => slide down to open
    open_popup_animate
  else
    # Popup is open => fade out to close
    close_popup_animate
  fi
}

case "$SENDER" in
  "mouse.clicked")
    if [ "$NAME" = "apple.logo" ]; then
      toggle_popup
    elif [ "$NAME" = "apple.preferences" ]; then
      open -a "System Settings"
      close_popup_animate
    elif [ "$NAME" = "apple.lock" ]; then
      pmset displaysleepnow
      close_popup_animate
    elif [ "$NAME" = "apple.reload" ]; then
      sketchybar --reload
      close_popup_animate
    else
      close_popup_animate
    fi
    ;;
  "mouse.exited.global")
    close_popup_animate
    ;;
esac
