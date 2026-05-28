# Homelab Architecture

This document explains the architecture of my self-hosted media automation stack.

## High-Level Flow

```text
User Request
↓
Seerr
↓
Radarr / Sonarr
↓
Prowlarr
↓
SABnzbd
↓
Usenet Provider
↓
Media Storage
↓
Plex
```

## Service Roles

### Seerr

Seerr is the request portal. It allows users to request movies and TV shows through a web interface.

### Radarr

Radarr manages movie requests. It monitors requested movies, searches indexers, sends downloads to SABnzbd, and imports completed movie files into the movie library.

### Sonarr

Sonarr manages TV shows. It monitors requested shows and episodes, searches indexers, sends downloads to SABnzbd, and imports completed episodes into the TV library.

### Prowlarr

Prowlarr manages indexers. It connects Radarr and Sonarr to Usenet or torrent indexers.

### SABnzbd

SABnzbd is the Usenet download client. It downloads NZB files from the Usenet provider and places completed downloads into a shared download folder.

### Plex

Plex is the media server. It scans the final movie and TV folders and makes the media available for streaming.

### Tailscale

Tailscale provides private remote access to the homelab without public port forwarding.

## Storage Layout

```text
/mnt/storage
├── docker
│   ├── radarr
│   ├── sonarr
│   ├── prowlarr
│   ├── sabnzbd
│   ├── overseerr
│   └── qbittorrent
│
├── media
│   ├── movies
│   └── tv
│
├── downloads
│   ├── complete
│   └── incomplete
│
├── backups
└── photos
```

## Container Path Mapping

The Docker containers see the media storage as:

```text
/media
```

The Ubuntu host sees the same storage as:

```text
/mnt/storage/media
```

Example:

```text
Host path:
/mnt/storage/media/movies

Container path:
/media/movies
```

This shared path allows SABnzbd, Radarr, Sonarr, and Plex to work together.

## Docker Network

The stack uses a shared Docker bridge network called:

```text
media_stack
```

This lets containers communicate by service name:

```text
radarr:7878
sonarr:8989
sabnzbd:8080
prowlarr:9696
seerr:5055
```

## Final Automation Flow

1. A user requests media in Seerr.
2. Seerr sends the request to Radarr or Sonarr.
3. Radarr/Sonarr search through Prowlarr.
4. Prowlarr queries configured indexers.
5. SABnzbd downloads the media through Usenet.
6. Radarr/Sonarr import the completed files.
7. Files are placed into `/media/movies` or `/media/tv`.
8. Plex scans the library and makes the media available.

