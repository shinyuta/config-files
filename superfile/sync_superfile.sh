#!/bin/bash

# Define paths
SOURCE_DIR="$HOME/.config/superfile"
DEST_DIR="$HOME/Library/Application Support/superfile"

# Ensure destination directory exists
mkdir -p "$DEST_DIR"

# Use rsync for better control (overrides existing files but keeps others)
rsync -av "$SOURCE_DIR/" "$DEST_DIR/"

# Confirm the operation
echo "✅ Superfile config synced to macOS default location."
