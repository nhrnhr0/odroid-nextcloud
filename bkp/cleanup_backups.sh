#!/bin/bash

# Load environment variables from .env file
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Load environment variables from the absolute path
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
else
    echo ".env file not found at $SCRIPT_DIR/.env"
    exit 1
fi

# Check if variables are set
if [ -z "$DEST_LOCATION" ] || [ -z "$MAX_COPYS" ]; then
    echo "DEST_LOCATION or MAX_COPYS is not set in the .env file."
    exit 1
fi

# Count the number of backup files in the destination folder
BACKUP_COUNT=$(ls -1 "$DEST_LOCATION"/backup_*.zip 2>/dev/null | wc -l)

# Check if the number of files exceeds MAX_COPYS
if [ "$BACKUP_COUNT" -gt "$MAX_COPYS" ]; then
    # Find the oldest file (sorted by modification date, oldest first)
    OLDEST_FILE=$(ls -1t "$DEST_LOCATION"/backup_*.zip | tail -n 1)

    if [ -n "$OLDEST_FILE" ]; then
        echo "Deleting oldest backup: $OLDEST_FILE"
        rm -f "$OLDEST_FILE"
    else
        echo "No files to delete."
    fi
else
    echo "No cleanup needed. Current backups: $BACKUP_COUNT, Limit: $MAX_COPYS"
fi
