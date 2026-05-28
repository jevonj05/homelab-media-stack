#!/bin/bash

DOWNLOAD_DIR="/mnt/storage/downloads/incomplete"
DAYS=2

echo "Cleaning incomplete downloads older than $DAYS days..."

find "$DOWNLOAD_DIR" -type f -mtime +$DAYS -print -delete

echo "Cleanup completed."
