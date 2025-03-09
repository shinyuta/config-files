#!/bin/bash
source "$CONFIG_DIR/colors.sh"

CORE_COUNT=$(sysctl -n machdep.cpu.thread_count)
CPU_INFO=$(ps -eo pcpu,user)

CPU_SYS=$(echo "$CPU_INFO" | grep -v $(whoami) | sed "s/[^ 0-9\.]//g" | \
  awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_USER=$(echo "$CPU_INFO" | grep $(whoami) | sed "s/[^ 0-9\.]//g" | \
  awk "{sum+=\$1} END {print sum/(100.0 * $CORE_COUNT)}")

CPU_PERCENT="$(echo "$CPU_SYS $CPU_USER" | awk '{printf "%.0f\n", ($1 + $2)*100}')"

# 1) Format the CPU usage as three digits (e.g. 007, 045, 100)
TRIPLE_CPU=$(printf "%03d" "$CPU_PERCENT")

# 2) Update SketchyBar with the triple-digit label
sketchybar --set "$NAME" \
  label="${TRIPLE_CPU}%" \
  label.color="$DIM" \
  icon.color="$DIM" \
  background.drawing=off
