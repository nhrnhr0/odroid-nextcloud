#!/bin/bash

# Define the absolute path to the script directory
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Load environment variables from the absolute path
if [ -f "$SCRIPT_DIR/.env" ]; then
    export $(grep -v '^#' "$SCRIPT_DIR/.env" | xargs)
else
    echo ".env file not found at $SCRIPT_DIR/.env"
    exit 1
fi

# Check if variables are set
if [ -z "$SRC_FOLDER" ] || [ -z "$DEST_LOCATION" ]; then
    echo "SRC_FOLDER or DEST_LOCATION is not set in the .env file."
    exit 1
fi

# Create a timestamp with date and time (YYYY-MM-DD_HH-MM-SS)
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Define the ZIP filename with prefix
ZIP_NAME="backup_${TIMESTAMP}.zip"

# Create the zip archive
zip -rq "$DEST_LOCATION/$ZIP_NAME" "$SRC_FOLDER"

# Check if the zip was created successfully
if [ $? -eq 0 ]; then
    echo "Backup created successfully: $DEST_LOCATION/$ZIP_NAME"
else
    echo "Failed to create backup."
    exit 1
fi
