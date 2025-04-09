#!/bin/zsh

# Enable nullglob so unmatched globs become empty arrays
setopt null_glob

# Define source and destination paths
DOWNLOADS="$HOME/Downloads"
LOG_FILE="$HOME/Desktop/scripts/organize_downloads.log"

# Clear previous log file contents
> "$LOG_FILE"

echo "==== Organizing Downloads - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Create destination folders if they do not exist
mkdir -p "$DOWNLOADS/Images" "$DOWNLOADS/Videos" "$DOWNLOADS/Documents" "$DOWNLOADS/Archives" "$DOWNLOADS/Folders" "$DOWNLOADS/Miscellaneous"

echo "Sorting files..." | tee -a "$LOG_FILE"

# Organize image files
images_files=("$DOWNLOADS"/*.{png,jpg,jpeg,gif,svg,webp})
images_count=${#images_files[@]}
if (( images_count > 0 )); then
    mv "${images_files[@]}" "$DOWNLOADS/Images/"
fi
echo "Moved $images_count image file(s) to Images folder." | tee -a "$LOG_FILE"

# Organize video files
videos_files=("$DOWNLOADS"/*.{mp4,mov,avi,mkv})
videos_count=${#videos_files[@]}
if (( videos_count > 0 )); then
    mv "${videos_files[@]}" "$DOWNLOADS/Videos/"
fi
echo "Moved $videos_count video file(s) to Videos folder." | tee -a "$LOG_FILE"

# Organize document files
docs_files=("$DOWNLOADS"/*.{pdf,docx,txt,md,rtf,odt,xlsx,pptx})
docs_count=${#docs_files[@]}
if (( docs_count > 0 )); then
    mv "${docs_files[@]}" "$DOWNLOADS/Documents/"
fi
echo "Moved $docs_count document file(s) to Documents folder." | tee -a "$LOG_FILE"

# Organize archive files (excluding .zip, which will be deleted)
archives_files=("$DOWNLOADS"/*.{tar.gz,rar,7z})
archives_count=${#archives_files[@]}
if (( archives_count > 0 )); then
    mv "${archives_files[@]}" "$DOWNLOADS/Archives/"
fi
echo "Moved $archives_count archive file(s) to Archives folder." | tee -a "$LOG_FILE"

# Delete .zip files
zip_files=("$DOWNLOADS"/*.zip)
zip_count=${#zip_files[@]}
if (( zip_count > 0 )); then
    rm -f "${zip_files[@]}"
fi
echo "Deleted $zip_count zip file(s)." | tee -a "$LOG_FILE"

# Delete .dmg files
dmg_files=("$DOWNLOADS"/*.dmg)
dmg_count=${#dmg_files[@]}
if (( dmg_count > 0 )); then
    rm -f "${dmg_files[@]}"
fi
echo "Deleted $dmg_count dmg file(s)." | tee -a "$LOG_FILE"

# Move any directories that are not one of our destination folders into "Folders"
other_dirs=()
for d in "$DOWNLOADS"/*(/); do
    base=$(basename "$d")
    case "$base" in
      Images|Videos|Documents|Archives|Folders|Miscellaneous)
        ;;  # Skip destination folders
      *)
        other_dirs+=("$d")
        ;;
    esac
done

other_dirs_count=${#other_dirs[@]}
if (( other_dirs_count > 0 )); then
    mv "${other_dirs[@]}" "$DOWNLOADS/Folders/"
fi
echo "Moved $other_dirs_count directory(ies) to Folders folder." | tee -a "$LOG_FILE"

# Move any remaining files (that are not directories) to "Miscellaneous"
remaining_files=("$DOWNLOADS"/*(.))
remaining_count=${#remaining_files[@]}
if (( remaining_count > 0 )); then
    mv "${remaining_files[@]}" "$DOWNLOADS/Miscellaneous/"
fi
echo "Moved $remaining_count remaining file(s) to Miscellaneous folder." | tee -a "$LOG_FILE"

echo "Download folder organized completely!" | tee -a "$LOG_FILE"
