#!/bin/bash

BACKUP_DIR="/mnt/storage/backups/docker-configs"
DATE=$(date +%Y-%m-%d_%H-%M-%S)

mkdir -p "$BACKUP_DIR"

tar -czvf "$BACKUP_DIR/config-backup-$DATE.tar.gz" /mnt/storage/docker

echo "Backup completed:"
echo "$BACKUP_DIR/config-backup-$DATE.tar.gz"
