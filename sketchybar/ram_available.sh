#!/bin/bash

# If you store colors in colors.sh, source them (optional)
# source "$CONFIG_DIR/colors.sh"

###############################################################################
# 1. Parse top’s “PhysMem” line
###############################################################################
# Example line:  PhysMem: 7569M used (1342M wired, 3416M compressor), 66M unused.
line=$(top -l 1 -s 0 | grep PhysMem)
[ -z "$line" ] && echo "No PhysMem line found." && exit 0

# Extract the total “used” portion in MB (e.g. "7569M")
total_used_mb=$(echo "$line" \
  | sed -E 's/.*PhysMem: ([0-9]+)M used.*/\1/')

# Extract the “wired” portion in MB (e.g. "1342M")
wired_mb=$(echo "$line" \
  | sed -E 's/.*\(([0-9]+)M wired.*/\1/')

# Extract the “compressor” portion in MB (e.g. "3416M")
compressor_mb=$(echo "$line" \
  | sed -E 's/.*wired, ([0-9]+)M compressor.*/\1/')

# Extract the “unused” portion in MB (e.g. "66M")
unused_mb=$(echo "$line" \
  | sed -E 's/.*([0-9]+)M unused.*/\1/')

###############################################################################
# 2. Calculate "Used by apps" (btop’s logic)
#    used_by_apps = total_used_mb - wired_mb - compressor_mb - unused_mb
###############################################################################
used_by_apps=$(( total_used_mb - wired_mb - compressor_mb - unused_mb ))
[ "$used_by_apps" -lt 0 ] && used_by_apps=0  # safety check if parsing was off

###############################################################################
# 3. Determine total memory (in MB).
#    On your Mac, 8 GiB is 8192 MB. We can also read hw.memsize from sysctl.
###############################################################################
# If you want to detect total memory automatically:
total_mem_bytes=$(sysctl -n hw.memsize)
total_mem_mb=$(( total_mem_bytes / 1024 / 1024 ))

# If you prefer to hardcode 8192 for an 8 GiB system, comment out the above two
# lines and simply do:
#   total_mem_mb=8192

###############################################################################
# 4. Compute "Available" = total_mem_mb - used_by_apps
###############################################################################
available_mb=$(( total_mem_mb - used_by_apps ))
[ "$available_mb" -lt 0 ] && available_mb=0

###############################################################################
# 5. Format the available percentage as XXX%
###############################################################################
available_percent=$(awk "BEGIN {printf \"%.0f\", ($available_mb / $total_mem_mb) * 100}")
formatted=$(printf "%03d" "$available_percent")

###############################################################################
# 6. Output the result (for testing in Terminal)
###############################################################################
echo "Available Memory: ${formatted}%"
echo "Details:"
echo "  total_used_mb = $total_used_mb MB"
echo "  wired_mb      = $wired_mb MB"
echo "  compressor_mb = $compressor_mb MB"
echo "  unused_mb     = $unused_mb MB"
echo "  used_by_apps  = $used_by_apps MB"
echo "  total_mem_mb  = $total_mem_mb MB"
echo "  available_mb  = $available_mb MB"
