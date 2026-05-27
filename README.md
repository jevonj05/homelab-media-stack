# Automated Media Homelab

This project documents my self-hosted media automation stack built on Ubuntu using Docker, Plex, Usenet, and Tailscale.

The goal of this homelab was to build a private media automation system where I can request a movie or TV show and have the full pipeline automatically download, organize, scan, and make it available in Plex.

---

# Stack

- Plex Media Server
- Seerr
- Radarr
- Sonarr
- Prowlarr
- SABnzbd
- qBittorrent
- Immich
- Tailscale
- Docker

---


# Architecture

```
Seerr
↓
Radarr / Sonarr
↓
Prowlarr
↓
SABnzbd
↓
Newshosting / Usenet
↓
Media Storage
↓
Plex


Storage Layout
/mnt/storage
├── backups
├── docker
├── downloads
├── media
│   ├── movies
│   └── tv
├── photos
└── homelab-git

What I Learned

This project helped me practice:

Ubuntu Linux Commands
Linux storage management
Docker containers
Docker networking
Bind mounts and persistent volumes
API configuration between services
Media automation
Service troubleshooting
Remote access with Tailscale
Git-based infrastructure documentation


Major Troubleshooting Lessons

Some of the biggest problems I solved included:

Docker containers being on different networks
Services failing because localhost inside a container does not mean the host machine
SABnzbd path issues between /config/Downloads and shared /media mounts
Linux mountpoints hiding files underneath /mnt/storage
Recovering media after a mount migration
Rebuilding Radarr after database corruption
Making Plex scan libraries automatically


Current Status

The full automation flow is working:

Request in Seerr

→ Radarr or Sonarr receives request
→ Prowlarr searches indexers
→ SABnzbd downloads through Usenet
→ Media imports into /mnt/storage/media
→ Plex scans and displays the content

Future Improvements
Add full Docker Compose management
Add automated backups
Add monitoring with Grafana
Add Tailscale access documentation
Add scripts for container updates
Add Recyclarr for quality profile management
Add Bazarr for subtitles
Add screenshots and architecture diagrams

Security Notes

This repository does not include:
API keys
Passwords
Plex tokens
Media files
Database files
Private photos
Real .env files
