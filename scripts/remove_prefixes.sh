#!/bin/zsh
# Uncomment the next line for debugging if needed:
# set -x

# Define log file path and truncate it
LOG_FILE="$HOME/Desktop/scripts/remove_prefixes.log"
: > "$LOG_FILE"

echo "==== Remove Prefixes Log - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Base directory containing class directories
DOC_DIR="$HOME/Desktop/documents"

# Loop over each item in the documents directory; process only if it's a directory.
for item in "$DOC_DIR"/*; do
    if [[ ! -d "$item" ]]; then
        continue
    fi

    class_dir="$item"
    class_name=$(basename "$class_dir")
    echo "Processing class directory: $class_name" | tee -a "$LOG_FILE"
    renamed_count=0

    # Create a temporary file to hold the list of files.
    tempfile="$(mktemp)"
    find "$class_dir" -type f -print0 | tr '\0' '\n' > "$tempfile"

    # Process each file from the temporary file.
    while read -r file; do
        base=$(basename "$file")

        # Skip .DS_Store files.
        if [[ "$base" == ".DS_Store" ]]; then
            echo "Skipping .DS_Store file: $file" | tee -a "$LOG_FILE"
            continue
        fi

        # Only process files that start with the class prefix.
        if [[ "$base" == "${class_name}_"* ]]; then
            # Remove the prefix using parameter expansion.
            new_base="${base#${class_name}_}"
            new_file="$(dirname "$file")/$new_base"
            echo "Renaming '$file' to '$new_file'" | tee -a "$LOG_FILE"
            mv -n "$file" "$new_file"
            renamed_count=$((renamed_count + 1))
        else
            echo "Skipping file (no matching prefix): $file" | tee -a "$LOG_FILE"
        fi
    done < "$tempfile"

    rm "$tempfile"
    echo "Total files renamed in $class_name: $renamed_count" | tee -a "$LOG_FILE"
done

echo "Remove prefixes process completed." | tee -a "$LOG_FILE"
