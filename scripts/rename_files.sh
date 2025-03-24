#!/bin/zsh
# Uncomment the next line for detailed debugging output:
# set -x

# Define log file path and truncate it
LOG_FILE="$HOME/Desktop/scripts/rename_files.log"
: > "$LOG_FILE"

# Log header
echo "==== File Renaming Log - $(date +"%Y-%m-%d %H:%M:%S") ====" >> "$LOG_FILE"

# Base directory containing class directories
DOC_DIR="$HOME/Desktop/documents"

# Loop over each item in DOC_DIR; process only if it is a directory.
for item in "$DOC_DIR"/*; do
    if [[ ! -d "$item" ]]; then
        continue
    fi

    class_dir="$item"
    class_name=$(basename "$class_dir")
    echo "Processing directory: $class_name" >> "$LOG_FILE"
    renamed_count=0
    skipped_count=0

    tempfile=$(mktemp)
    find "$class_dir" -type f -print0 | tr '\0' '\n' > "$tempfile"

    while IFS= read -r file; do
        base=$(basename "$file")

        # Skip .DS_Store files
        if [[ "$base" == ".DS_Store" ]]; then
            echo "Skipping .DS_Store file: $file" >> "$LOG_FILE"
            ((skipped_count++))
            continue
        fi

        # Skip files already renamed with the class prefix
        if [[ "$base" == "${class_name}_"* ]]; then
            echo "Skipping already renamed file: $file" >> "$LOG_FILE"
            ((skipped_count++))
            continue
        fi

        # Process only supported file types
        case "$base" in
            *.pdf|*.PDF|*.md|*.MD|*.markdown|*.MARKDOWN|\
            *.jpg|*.JPG|*.jpeg|*.JPEG|*.png|*.PNG|\
            *.gif|*.GIF|*.bmp|*.BMP|*.svg|*.SVG)
                ;;
            *)
                echo "Skipping unsupported file type: $file" >> "$LOG_FILE"
                ((skipped_count++))
                continue
                ;;
        esac

        # Construct the new filename with the class prefix
        new_file="$(dirname "$file")/${class_name}_${base}"
        echo "Renaming '$file' to '$new_file'" >> "$LOG_FILE"
        mv -n "$file" "$new_file"
        ((renamed_count++))
    done < "$tempfile"

    rm "$tempfile"

    # Print a single summary line to the terminal for this directory
    summary="Directory: $class_name: Renamed $renamed_count file(s), Skipped $skipped_count file(s)"
    echo "$summary"
    echo "$summary" >> "$LOG_FILE"
done

echo "Renaming process completed." >> "$LOG_FILE"
