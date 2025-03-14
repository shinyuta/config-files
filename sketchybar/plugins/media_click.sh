#!/bin/bash

# Detect Spotify playback state
SPOTIFY_RUNNING=$(pgrep -x "Spotify" >/dev/null && echo "yes" || echo "no")
SPOTIFY_STATE="stopped"

if [[ "$SPOTIFY_RUNNING" == "yes" ]]; then
  SPOTIFY_STATE=$(osascript -e 'tell application "Spotify" to player state' 2>/dev/null)
fi

# Detect if other media is playing (like Apple Music, YouTube, etc.)
OTHER_MEDIA_PLAYING=$(osascript -e '
  tell application "System Events"
    set activeApps to (name of every process where background only is false)
  end tell
  return activeApps' | grep -E "Music|Safari|Google Chrome|Firefox|Edge" | wc -l)

# Toggle playback
if [[ "$SPOTIFY_STATE" == "playing" ]]; then
  osascript -e 'tell application "Spotify" to pause'
elif [[ "$SPOTIFY_STATE" == "paused" ]]; then
  osascript -e 'tell application "Spotify" to play'
elif [[ "$OTHER_MEDIA_PLAYING" -gt 0 ]]; then
  osascript -e 'tell application "System Events" to key code 16' # Simulate media key (Play/Pause)
fi
