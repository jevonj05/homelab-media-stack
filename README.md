# Automated Media Homelab

A self-hosted Ubuntu environment built to automate media acquisition, organization, storage, and remote access using Docker-based services and a dedicated storage architecture.

This repository documents the infrastructure, configuration approach, troubleshooting process, and operational lessons behind the build.

## Project Overview

The goal was to create a reliable homelab workflow where a media request can move through discovery, download, organization, and library availability with minimal manual intervention.

```text
Request
  ↓
Seerr
  ↓
Radarr / Sonarr
  ↓
Prowlarr
  ↓
SABnzbd / qBittorrent
  ↓
Media Storage
  ↓
Plex
```

## Technology Stack

- Ubuntu Linux
- Docker / Docker Compose
- Plex Media Server
- Seerr
- Radarr
- Sonarr
- Prowlarr
- SABnzbd
- qBittorrent
- Immich
- Tailscale
- Git

## Storage Architecture

```text
/mnt/storage
├── backups
├── docker
├── downloads
├── media
│   ├── movies
│   └── tv
├── photos
└── homelab-git
```

Persistent application data, downloads, media libraries, photos, backups, and Git-managed homelab files are separated to make the environment easier to maintain and recover.

## Engineering Challenges

Building the stack required troubleshooting several real infrastructure issues, including:

- Docker containers operating on different networks
- Understanding why `localhost` inside a container does not refer to the Docker host
- Resolving inconsistent download and import paths between containers
- Managing Linux mount points without hiding existing data
- Recovering media during a storage migration
- Rebuilding Radarr after database corruption
- Configuring Plex library scans after automated imports
- Maintaining persistent application data across container changes

## What I Practiced

This project provided hands-on experience with:

- Linux system administration
- Docker containers and networking
- Bind mounts and persistent volumes
- Linux storage management
- Service-to-service API configuration
- Infrastructure troubleshooting
- Remote access through Tailscale
- Git-based infrastructure documentation
- Designing recoverable self-hosted services

## Current Status

The primary automation pipeline is operational:

```text
Request → Search → Download → Import → Store → Plex Library
```

The repository is being expanded as the homelab evolves.

## Roadmap

- [ ] Expand Docker Compose management
- [ ] Add automated configuration backups
- [ ] Add service and host monitoring
- [ ] Document Tailscale remote administration
- [ ] Add container maintenance scripts
- [ ] Add Recyclarr quality-profile management
- [ ] Add Bazarr subtitle automation
- [ ] Add architecture diagrams and sanitized screenshots
- [ ] Integrate the environment with my Homelab Sysadmin AI project

## Security

Secrets and private data are intentionally excluded from this repository. Public commits should never contain:

- API keys
- Passwords
- Plex tokens
- Private IP or identity information that is not required for documentation
- Media files
- Application databases
- Private photos
- Production `.env` files

Example configuration should use placeholders or sanitized values.

## Related Work

This homelab is also the test environment for an in-development **AI-assisted Linux system administration project** that uses Python health checks, Docker diagnostics, network checks, and a local Ollama model to analyze system state and assist with troubleshooting.

---

**Built and documented by Jevon Johnson**
