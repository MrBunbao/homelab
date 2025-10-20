# Syncthing

Continuous file synchronization across devices.

## Overview

Syncthing is a decentralized, peer-to-peer file sync solution that keeps files synchronized across multiple devices without requiring a central server.

## Docker Compose Configuration

```yaml
services:
  syncthing:
    image: syncthing/syncthing:latest
    container_name: syncthing
    hostname: homelab-sync
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=America/Denver
    volumes:
      - /path/to/config:/var/syncthing
      - /path/to/data:/data
    ports:
      - 8384:8384   # Web UI
      - 22000:22000/tcp  # Sync protocol
      - 22000:22000/udp
      - 21027:21027/udp  # Local discovery
    restart: unless-stopped
```

## Access

- Web UI: `http://localhost:8384`
- Default sync folder: `/data`

## Configuration

1. Open the web UI
2. Add remote devices by exchanging device IDs
3. Configure folders to share
4. Set ignore patterns as needed
