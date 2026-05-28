# Storage Documentation

This document explains the storage configuration used in the homelab environment.

## Storage Overview

The homelab uses a dedicated mounted HDD for persistent storage.

Mount location:

```text
/mnt/storage
```

This drive stores:

* Docker application data
* Media libraries
* Downloads
* Backups
* Photos

## Storage Layout

```text
/mnt/storage
├── backups
├── docker
├── downloads
│   ├── complete
│   └── incomplete
├── media
│   ├── movies
│   └── tv
├── photos
└── homelab-git
```

## Purpose of Each Directory

### docker

Stores persistent Docker container application data.

Examples:

```text
/mnt/storage/docker/radarr
/mnt/storage/docker/sonarr
/mnt/storage/docker/sabnzbd
```

This ensures container data survives restarts and updates.

### downloads

Temporary download location used by SABnzbd and qBittorrent.

Structure:

```text
complete
incomplete
```

* incomplete = active downloads
* complete = finished downloads awaiting import

### media

Final organized media library used by Plex.

Structure:

```text
movies
tv
```

This directory is mounted into:

* Plex
* Radarr
* Sonarr
* SABnzbd

### backups

Stores compressed backups of Docker configuration data.

### photos

Reserved for future photo storage and Immich integration.

## Docker Volume Mapping

Containers access media through shared bind mounts.

Example:

```text
Host:
/mnt/storage/media

Container:
/media
```

This shared path allows automation between services.

## Persistent Storage Benefits

Using bind mounts provides:

* Persistent application data
* Easier backups
* Easier migrations
* Simpler recovery
* Better visibility into container files

## Mountpoint Lessons Learned

A major issue occurred when mounting the HDD to:

```text
/mnt/storage
```

Linux mountpoints hide the original underlying directory contents.

This caused files to appear missing even though they still existed underneath the mountpoint.

## Recovery Process

Recovery involved:

* Unmounting the drive
* Checking open processes
* Copying files from containers
* Rebuilding directory structure
* Reconfiguring Docker mounts

Commands used:

```bash
sudo umount /mnt/storage
sudo lsof +D /mnt/storage
docker cp
find
```

## Permission Management

The homelab uses:

```text
PUID=1000
PGID=1000
```

to align Docker container permissions with the host Linux user.

This prevents:

* Permission denied errors
* Failed imports
* Inaccessible media files

## SSD Usage

The SSD is used for:

* Ubuntu operating system
* Docker temporary operations
* Plex transcoding cache
* SABnzbd temporary cache

The HDD is used for:

* Long-term media storage
* Persistent application data
* Backups

## Lessons Learned

* Always verify mountpoints before moving data
* Separate temporary and persistent storage
* Shared media paths simplify automation
* Consistent bind mounts prevent import failures
* SSD cache locations improve Plex performance
* Backups are critical before storage migrations

