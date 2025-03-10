#!/bin/bash
source "$CONFIG_DIR/colors.sh"

###############################################################################
# CONFIG
###############################################################################
POPUP_ITEM="net.speed"
IFACE="en0"
TMP_FILE="/tmp/sketchybar_${IFACE}_net.tmp"

###############################################################################
# ANIMATION LOGIC
###############################################################################
close_popup_animate() {
  # Step A: Make parent's popup background opaque
  sketchybar --set "$POPUP_ITEM" popup.background.color=0xcc000000

  # Step B: Child items fully visible (dim)
  for child in net.totals; do
    sketchybar --set "$child" \
      icon.color="$DIM" \
      label.color="$DIM"
  done

  # Step C: Animate parent's background to transparent
  sketchybar --animate sin 20 --set "$POPUP_ITEM" popup.background.color=0x00000000

  # Step D: Animate child items' color to transparent
  for child in net.totals; do
    sketchybar --animate sin 20 --set "$child" \
      icon.color=0x00ffffff \
      label.color=0x00ffffff
  done

  # Step E: Wait ~0.33s
  sleep 0.33

  # Step F: Hide popup, reset offsets/colors
  sketchybar --set "$POPUP_ITEM" \
    popup.drawing=off \
    popup.y_offset=0 \
    popup.background.color=0xcc000000

  for child in net.totals; do
    sketchybar --set "$child" \
      icon.color="$DIM" \
      label.color="$DIM"
  done
}

open_popup_animate() {
  sketchybar --set "$POPUP_ITEM" \
    popup.y_offset=-20 \
    popup.background.color=0xcc000000 \
    popup.drawing=on

  sketchybar --animate sin 10 --set "$POPUP_ITEM" popup.y_offset=0
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

###############################################################################
# NETWORK CALCULATIONS
###############################################################################
# Convert bytes to KiB
to_kib() {
  local bytes=$1
  awk "BEGIN {printf \"%.2f\", $bytes/1024}"
}

# Convert bytes to GiB
to_gib() {
  local bytes=$1
  awk "BEGIN {printf \"%.2f\", $bytes/1073741824}"
}

update_net_usage() {
  # Grab RX/TX from netstat line containing "Link" (excluding header "Name")
  read rx_boot tx_boot < <(netstat -ibn -I "$IFACE" | awk '/Link/ && !/Name/ {print $7, $10; exit}')

  # If empty, do nothing
  [ -z "$rx_boot" ] && return
  [ -z "$tx_boot" ] && return

  local now
  now=$(date +%s)
  if [ -f "$TMP_FILE" ]; then
    . "$TMP_FILE"  # old_time, old_rx, old_tx
  else
    old_time=$now
    old_rx=$rx_boot
    old_tx=$tx_boot
  fi

  local delta_time=$(( now - old_time ))
  [ "$delta_time" -eq 0 ] && delta_time=1

  local delta_rx=$(( rx_boot - old_rx ))
  local delta_tx=$(( tx_boot - old_tx ))

  # DEBUG: Log to /tmp/net_debug.log
  echo "DEBUG: old_rx=$old_rx old_tx=$old_tx new_rx=$rx_boot new_tx=$tx_boot delta_rx=$delta_rx delta_tx=$delta_tx" >> /tmp/net_debug.log

  # Speeds in KiB/s
  local rx_speed_kibs
  local tx_speed_kibs
  rx_speed_kibs=$(awk "BEGIN {printf \"%.2f\", $delta_rx / $delta_time / 1024}")
  tx_speed_kibs=$(awk "BEGIN {printf \"%.2f\", $delta_tx / $delta_time / 1024}")

  # Totals in GiB
  local rx_total_gib
  local tx_total_gib
  rx_total_gib=$(to_gib "$rx_boot")
  tx_total_gib=$(to_gib "$tx_boot")

  # Update bar item (speeds in KiB/s)
  sketchybar --set net.speed \
    label="↑ ${tx_speed_kibs}KiB/s ↓ ${rx_speed_kibs}KiB/s" \
    label.color="$DIM" \
    icon.color="$DIM"

  # Update popup item (totals in GiB, one line)
  sketchybar --set net.totals \
    label="↑ ${tx_total_gib}GiB ↓ ${rx_total_gib}GiB" \
    label.color="$DIM" \
    icon.color="$DIM"

  # Save new counters
  cat <<EOF > "$TMP_FILE"
old_time=$now
old_rx=$rx_boot
old_tx=$tx_boot
EOF
}

###############################################################################
# EVENT HANDLER
###############################################################################
case "$SENDER" in
  "mouse.clicked")
    if [ "$NAME" = "net.speed" ]; then
      toggle_popup
    else
      close_popup_animate
    fi
    ;;
  "mouse.exited.global")
    close_popup_animate
    ;;
  *)
    update_net_usage
    ;;
esac
