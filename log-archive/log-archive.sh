#!/bin/bash

# 1. Check if the user provided an argument (the log directory)
if [ -z "$1" ]; then
    echo "Error: No directory specified."
    echo "Usage: ./log-archive.sh <log-directory>"
    exit 1
fi

# Store the input directory path
LOG_DIR=$1

# 2. Check if the specified directory actually exists
if [ ! -d "$LOG_DIR" ]; then
    echo "Error: Directory '$LOG_DIR' does not exist."
    exit 1
fi

# 3. Setup archive storage directory (e.g., an 'archives' folder in your home directory)
ARCHIVE_DEST="$HOME/archived_logs"
mkdir -p "$ARCHIVE_DEST"

# 4. Generate dynamic timestamp and unique filename
# Format: YYYYMMDD_HHMMSS (e.g., 20260613_170532)
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"

echo "Starting archive of: $LOG_DIR..."

# 5. Compress the folder using tar and gzip
# -c: create, -z: gzip compress, -f: output file name
tar -czf "$ARCHIVE_DEST/$ARCHIVE_NAME" -C "$LOG_DIR" .

# Check if the tar command succeeded
if [ $? -eq 0 ]; then
    echo "Success! Compressed archive saved to: $ARCHIVE_DEST/$ARCHIVE_NAME"
    
    # 6. Log the event to a history file (with date, time, and archive name)
    HISTORY_LOG="$ARCHIVE_DEST/archive_history.log"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archived '$LOG_DIR' to '$ARCHIVE_NAME'" >> "$HISTORY_LOG"
    echo "Log history updated in: $HISTORY_LOG"
else
    echo "Error: Failed to create archive."
    exit 1
fi
