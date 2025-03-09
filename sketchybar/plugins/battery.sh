#!/bin/sh
source "$CONFIG_DIR/colors.sh"

# 1) Read the battery percentage (integer only)
PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

# If no percentage found, do nothing
if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

# 2) Pick an icon based on the percentage
case "${PERCENTAGE}" in
  9[0-9]|100) ICON="" ;;
  [6-8][0-9]) ICON="" ;;
  [3-5][0-9]) ICON="" ;;
  [1-2][0-9]) ICON="" ;;
  *)          ICON="" ;;
esac

# 3) Determine if charging
#    If charging, icon is "" and color is $GREEN.
#    Otherwise, use $DIM color.
if [[ "$CHARGING" != "" ]]; then
  ICON=""
  ICON_COLOR="$GREEN"
  LABEL_COLOR="$GREEN"
else
  ICON_COLOR="$DIM"
  LABEL_COLOR="$DIM"
fi

# 4) Format the battery as triple digits
TRIPLE_BATT=$(printf "%03d" "$PERCENTAGE")

# 5) Update SketchyBar with the triple-digit label
sketchybar --set "$NAME" \
  icon="$ICON" \
  label="${TRIPLE_BATT}%" \
  icon.color="$ICON_COLOR" \
  label.color="$LABEL_COLOR" \
  background.drawing=off
