#!/bin/zsh
# Hard link all files from ~/Desktop/scripts to ~/.config/scripts

# Define source and target directories.
SOURCE_DIR="$HOME/Desktop/scripts"
TARGET_DIR="$HOME/.config/scripts"

# Ensure the target directory exists.
mkdir -p "$TARGET_DIR"

# Loop through all files in the source directory.
for file in "$SOURCE_DIR"/*; do
    # Only process regular files (skip directories and symlinks).
    if [[ -f "$file" ]]; then
        base=$(basename "$file")
        target="$TARGET_DIR/$base"
        # Only create the hard link if the target file doesn't already exist.
        if [[ ! -e "$target" ]]; then
            ln "$file" "$target"
            echo "Created hard link for $file at $target"
        else
            echo "File $target already exists. Skipping."
        fi
    fi
done
