# Networking Documentation

This document explains the networking configuration used in the homelab environment.

## Docker Networking Overview

The media stack uses a shared Docker bridge network named:

```text
media_stack
```

This allows all containers to communicate internally using container names instead of localhost or IP addresses.

## Why Docker Networks Matter

Containers are isolated by default.

Without a shared Docker network:

* Seerr cannot communicate with Radarr
* Radarr cannot communicate with SABnzbd
* Sonarr cannot communicate with Prowlarr

Containers must either:

* Share a Docker network
* Use host networking
* Expose ports externally

The homelab uses a shared bridge network for simplicity and security.

## Internal Container Communication

Containers communicate internally using:

```text
container-name:port
```

Examples:

```text
radarr:7878
sonarr:8989
sabnzbd:8080
prowlarr:9696
seerr:5055
```

This only works if containers share the same Docker network.

## Why Localhost Failed

Inside a container:

```text
localhost
```

refers to:

```text
the container itself
```

NOT the host machine.

Example:

```text
localhost:7878
```

inside Seerr means:

```text
Seerr trying to connect to itself
```

instead of the Radarr container.

The correct configuration is:

```text
radarr:7878
```

## Docker Bridge Network

The stack uses:

```yaml
networks:
  media_stack:
    driver: bridge
```

Bridge networking allows:

* Internal container communication
* Network isolation
* Simpler service discovery
* Better security than exposing everything publicly

## Viewing Docker Networks

List Docker networks:

```bash
docker network ls
```

Inspect a network:

```bash
docker network inspect media_stack
```

## Viewing Container Networks

Check which network a container belongs to:

```bash
docker inspect radarr
```

## Tailscale Remote Access

Tailscale provides secure remote access to the homelab without exposing ports to the public internet.

Benefits:

* Encrypted traffic
* No port forwarding required
* Private network access
* Secure remote administration

## Current Network Architecture

```text
Laptop / Phone
↓
Tailscale
↓
Ubuntu Homelab Server
↓
Docker Bridge Network
↓
Media Stack Containers
```

## Lessons Learned

* Docker containers should communicate through shared networks
* Localhost inside containers does not refer to the host machine
* Shared Docker bridge networks simplify service discovery
* Tailscale is safer than exposing ports publicly
* Consistent networking design prevents automation failures
