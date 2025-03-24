#!/bin/zsh

# Enable nullglob to ensure that unmatched globs result in an empty list
setopt null_glob

# Define source and destination paths
DOWNLOADS="$HOME/Downloads"
LOG_FILE="$HOME/Desktop/scripts/organize_downloads.log"
> "$LOG_FILE"

echo "==== Organizing Downloads - $(date +"%Y-%m-%d %H:%M:%S") ====" | tee -a "$LOG_FILE"

# Create destination folders if they do not exist
mkdir -p "$DOWNLOADS/Images" "$DOWNLOADS/Videos" "$DOWNLOADS/Documents" "$DOWNLOADS/Archives"

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

# Organize archive files
archives_files=("$DOWNLOADS"/*.{zip,tar.gz,rar,7z})
archives_count=${#archives_files[@]}
if (( archives_count > 0 )); then
    mv "${archives_files[@]}" "$DOWNLOADS/Archives/"
fi
echo "Moved $archives_count archive file(s) to Archives folder." | tee -a "$LOG_FILE"

echo "Download folder organized!" | tee -a "$LOG_FILE"
