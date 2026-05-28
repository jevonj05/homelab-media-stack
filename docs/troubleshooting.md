# Troubleshooting Guide

This document contains major issues encountered while building the homelab environment and the steps used to resolve them.

## Docker Containers Could Not Communicate

### Problem

Seerr could not connect to Radarr or Sonarr.

Example error:

```text id="9xxvru"
Unable to connect to Radarr
Connection refused
```

### Cause

Containers were running on different Docker bridge networks.

### Resolution

Connected all services to a shared Docker network:

```text id="fw9e3i"
media_stack
```

Updated the Docker Compose configuration to attach all containers to the same bridge network.

### Lesson Learned

Containers should communicate using Docker service names instead of localhost.

Example:

```text id="jlwm220"
radarr:7878
sabnzbd:8080
```

instead of:

```text id="jlwm221"
localhost:7878
```

## Linux Mountpoint Hid Existing Files

### Problem

After mounting the HDD to:

```text id="jlwm222"
/mnt/storage
```

all previous folders appeared missing.

### Cause

Linux mountpoints hide the underlying directory contents when a filesystem is mounted over them.

### Resolution

Unmounted the drive and recovered the hidden files.

Used:

```bash id="jlwm223"
sudo umount /mnt/storage
```

and verified open processes with:

```bash id="jlwm224"
sudo lsof +D /mnt/storage
```

### Lesson Learned

Always verify mountpoints before moving important files.

## SABnzbd Download Path Issues

### Problem

Radarr and Sonarr could not import completed downloads.

Example error:

```text id="’wini225"
Directory does not appear to exist inside the container
```

### Cause

Containers used inconsistent volume mappings.

### Resolution

Mapped all media-related containers to the same shared media path:

```text id="’wini226"
/media
```

### Lesson Learned

Consistent container path mapping is critical for Docker media stacks.

## Radarr Database Corruption

### Problem

Radarr UI failed to load and returned empty responses.

### Cause

Corrupted application database or broken configuration state.

### Resolution

Rebuilt the Radarr container and restored configuration manually.

### Lesson Learned

Always maintain backups of Docker configuration directories.

## Plex Buffering Issues

### Problem

Plex playback buffered during streaming.

### Cause

High bitrate media and audio transcoding.

### Resolution

Enabled hardware acceleration and moved temporary transcoding operations to SSD storage.

### Lesson Learned

Transcoding performance depends heavily on storage speed and hardware acceleration support.

## Permission Denied Errors

### Problem

Docker containers could not access mounted files or directories.

### Cause

Linux ownership and permission mismatches between host and containers.

### Resolution

Verified permissions and aligned container PUID and PGID values with the host user.

Example:

```text id="’wini227"
PUID=1000
PGID=1000
```

### Lesson Learned

Linux permissions and ownership are critical when using bind mounts with Docker.

## Media Recovery After Mount Changes

### Problem

Media files appeared missing after storage migration.

### Cause

Files existed inside container mount paths but had not been copied correctly to the mounted HDD.

### Resolution

Recovered files using:

```bash id="’wini228"
docker cp
```

and verified media locations using:

```bash id="’wini229"
find
```

### Lesson Learned

Always validate storage paths before deleting old data.
