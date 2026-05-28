# Homelab Maintenance Scripts

This document explains the maintenance and automation scripts used in the homelab environment.

## Script Directory

```text id="jlwm203"
scripts/
├── update-containers.sh
├── backup-configs.sh
├── cleanup-downloads.sh
└── check-services.sh
```

## update-containers.sh

This script updates all Docker containers in the media stack.

### Functions

* Pulls latest container images
* Recreates containers with updated images
* Removes unused Docker images

### Script Flow

```text id="jlwm204"
Pull latest images
↓
Recreate containers
↓
Remove unused images
↓
Complete
```

### Usage

```bash id="jlwm205"
./scripts/update-containers.sh
```

### Key Commands Used

```bash id="jlwm206"
docker compose pull
docker compose up -d
docker image prune -f
```

## backup-configs.sh

This script creates compressed backups of Docker configuration data.

### Backup Target

```text id="jlwm207"
/mnt/storage/docker
```

### Backup Destination

```text id="jlwm208"
/mnt/storage/backups/docker-configs
```

### Features

* Automatically creates timestamped backups
* Compresses configuration data using tar.gz
* Creates backup directory if it does not exist

### Script Flow

```text id="jlwm209"
Create backup directory
↓
Generate timestamp
↓
Compress Docker configs
↓
Store backup archive
```

### Usage

```bash id="jlwm210"
./scripts/backup-configs.sh
```

### Key Commands Used

```bash id="’wini211"
tar -czvf
mkdir -p
date
```

## cleanup-downloads.sh

This script automatically removes old incomplete downloads.

### Cleanup Target

```text id="’wini212"
/mnt/storage/downloads/incomplete
```

### Features

* Removes files older than a specified number of days
* Helps prevent SSD storage exhaustion
* Automatically deletes stale download files

### Script Flow

```text id="’wini213"
Search incomplete downloads
↓
Find files older than configured threshold
↓
Delete old files
↓
Complete
```

### Usage

```bash id="’wini214"
./scripts/cleanup-downloads.sh
```

### Key Commands Used

```bash id="’wini215"
find
-delete
-mtime
```

## check-services.sh

This script provides a quick health check of the homelab environment.

### Features

* Displays running Docker containers
* Shows storage usage
* Displays Docker disk usage statistics

### Script Flow

```text id="’wini216"
Check running containers
↓
Display disk usage
↓
Display Docker storage usage
↓
Complete
```

### Usage

```bash id="’wini217"
./scripts/check-services.sh
```

### Key Commands Used

```bash id="’wini218"
docker ps
df -h
docker system df
```

## Permissions

All scripts are configured as executable using:

```bash id="’wini219"
chmod +x script-name.sh
```

This allows Linux to execute the scripts directly.

## Future Improvements

Planned improvements for the automation scripts include:

* Scheduled backups using cron
* Discord or email notifications
* Automatic container health monitoring
* Log rotation
* Automatic failed container recovery
* Remote backup synchronization
* Grafana monitoring integration
* Ollama LLM Integration
