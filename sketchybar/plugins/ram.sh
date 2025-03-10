#!/bin/bash
# Calculates the "Available" memory percentage on macOS in a similar way to btop.
# Then updates the SketchyBar item named $NAME with a triple-digit percentage.

# Optionally load your colors if needed:
source "$CONFIG_DIR/colors.sh"

###############################################################################
# Parse the "PhysMem" line from `top -l 1 -s 0`
###############################################################################
line=$(top -l 1 -s 0 | grep PhysMem)
[ -z "$line" ] && exit 0

# Extract the total "used" portion in MB (e.g. 7560M)
total_used_mb=$(echo "$line" \
  | sed -E 's/.*PhysMem: ([0-9]+)M used.*/\1/')

# Extract the "wired" portion in MB (e.g. 1404M)
wired_mb=$(echo "$line" \
  | sed -E 's/.*\(([0-9]+)M wired.*/\1/')

# Extract the "compressor" portion in MB (e.g. 2940M)
compressor_mb=$(echo "$line" \
  | sed -E 's/.*wired, ([0-9]+)M compressor.*/\1/')

# Extract the "unused" portion in MB (e.g. 5M)
unused_mb=$(echo "$line" \
  | sed -E 's/.*([0-9]+)M unused.*/\1/')

###############################################################################
# Calculate how much is "used by apps" (btop logic)
###############################################################################
# used_by_apps = total_used_mb - wired_mb - compressor_mb - unused_mb
used_by_apps=$(( total_used_mb - wired_mb - compressor_mb - unused_mb ))
[ "$used_by_apps" -lt 0 ] && used_by_apps=0  # safety clamp

###############################################################################
# Determine total memory in MB (8 GiB => 8192 MB, etc.)
###############################################################################
total_mem_bytes=$(sysctl -n hw.memsize)
total_mem_mb=$(( total_mem_bytes / 1024 / 1024 ))

###############################################################################
# Calculate "available" memory
###############################################################################
available_mb=$(( total_mem_mb - used_by_apps ))
[ "$available_mb" -lt 0 ] && available_mb=0

# Compute available percentage (rounded to integer)
available_percent=$(awk "BEGIN {printf \"%.0f\", ($available_mb / $total_mem_mb) * 100}")

# Format as triple-digit (e.g., "061%")
formatted=$(printf "%03d" "$available_percent")

###############################################################################
# Update the SketchyBar item with the result
###############################################################################
sketchybar --set "$NAME" \
  label="${formatted}%" \
  background.drawing=off
