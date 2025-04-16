#!/bin/bash

source "$CONFIG_DIR/colors.sh"

STATE="$(echo "$INFO" | jq -r '.state')"
APP="$(echo "$INFO" | jq -r '.app')"

# Function to update the SketchyBar media item
update_media() {
  sketchybar --set "$NAME" label="$1" label.color="$2" icon="$3" icon.color="$2" drawing=on
}

# Check if Spotify is playing
SPOTIFY_STATE=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null || echo "stopped")

if [[ "$SPOTIFY_STATE" == "playing" ]]; then
  SONG=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)
  update_media "$SONG - $ARTIST" "$GREEN" "󰎆"
  exit 0
fi

# Check if non-Spotify media is playing or if the active app is Dia Browser
# Check if non-Spotify media is playing or if the active app is Dia Browser
if [[ "$STATE" == "playing" || "$APP" == "company.thebrowser.dia" ]]; then
  MEDIA="$(echo "$INFO" | jq -r '.title + " - " + .artist')"

  # If the media string is empty or only a dash, try to use the last stored media
  if [[ -z "$MEDIA" || "$MEDIA" == " - " ]]; then
    if [[ -f "$HOME/.config/sketchybar/last_media.txt" && -s "$HOME/.config/sketchybar/last_media.txt" ]]; then
      MEDIA="$(cat "$HOME/.config/sketchybar/last_media.txt")"
    fi
  fi

  # Only update the media if there is a non-empty string
  if [[ -n "$MEDIA" ]]; then
    if [[ "$APP" == "company.thebrowser.dia" ]]; then
      ICON=""  # Replace with Dia-specific icon if desired
    else
      ICON=""
    fi

    update_media "$MEDIA" "$ACCENT_COLOR" "$ICON"

    # Store the last known playing media to prevent disappearing issues
    echo "$MEDIA" > "$HOME/.config/sketchybar/last_media.txt"
    echo "$APP" > "$HOME/.config/sketchybar/last_media_app.txt"
  fi
  exit 0
fi

# If no new media detected, check the last stored media (prevents disappearing bug)
if [[ -f "$HOME/.config/sketchybar/last_media.txt" && -f "$HOME/.config/sketchybar/last_media_app.txt" ]]; then
  LAST_MEDIA=$(cat "$HOME/.config/sketchybar/last_media.txt")
  LAST_APP=$(cat "$HOME/.config/sketchybar/last_media_app.txt")

  # Prevent stuck UI by checking if the last app was Spotify (since we already handle it)
  if [[ "$LAST_APP" != "Spotify" ]]; then
    update_media "$LAST_MEDIA" "$ACCENT_COLOR" ""
    exit 0
  fi
fi

# If nothing is playing at all, hide the media item
sketchybar --set "$NAME" drawing=off
