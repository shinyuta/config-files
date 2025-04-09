#!/bin/zsh
# delete_downloads.sh
# This script deletes the contents of the organized subdirectories in your Downloads folder
# and logs the results to a log file.

# Enable nullglob so that unmatched globs result in an empty array
setopt null_glob

# Define source folder and log file location
DOWNLOADS="$HOME/Downloads"
LOG_FILE="$HOME/Desktop/scripts/delete_downloads.log"

# Clear previous log file contents
: > "$LOG_FILE"

echo "==== Deleting Downloads Contents - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# List the organized subdirectories
organized_dirs=(Images Videos Documents Archives Folders Miscellaneous)

# Loop over each directory and delete its contents without removing the directory itself
for dir in "${organized_dirs[@]}"; do
    target="$DOWNLOADS/$dir"
    if [[ -d "$target" ]]; then
        # Count number of items (files/directories, including hidden ones) within the directory.
        count=$(find "$target" -mindepth 1 | wc -l)
        if (( count > 0 )); then
            # Delete non-hidden files/directories
            rm -rf "$target"/*
            # Delete hidden files/directories, making sure not to touch "." or ".."
            rm -rf "$target"/.[!.]* "$target"/..?*
            echo "Deleted $count item(s) from '$dir' folder." | tee -a "$LOG_FILE"
        else
            echo "'$dir' folder was already empty." | tee -a "$LOG_FILE"
        fi
    else
        echo "'$dir' folder does not exist in Downloads. Skipping." | tee -a "$LOG_FILE"
    fi
done

echo "All organized Downloads folders have been cleaned." | tee -a "$LOG_FILE"
