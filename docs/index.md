# BaoLabs Homelab

Welcome to my homelab documentation! This site documents my self-hosted infrastructure, services, and configurations.

- 📦 Repository: [github.com/mrbunbao/homelab](https://github.com/mrbunbao/homelab)
- ✏️ Edit pages: Use the "Edit on GitHub" button in the top-right corner

## Architecture Overview

The homelab is built on a multi-layered architecture:

```
┌─────────────────────────────────────────────────────────┐
│                    Internet/WAN                          │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  Cloudflare (DNS, DDNS, DDoS Protection, WAF)           │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  Reverse Proxy Layer (Traefik + Let's Encrypt SSL)      │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  UniFi Network (VLANs, Routing, Firewall)                │
│  AdGuard Home (DNS, Ad-blocking, Local Resolution)      │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  Service Layer (Docker Containers)                       │
│  ├─ Media (Jellyfin)                                     │
│  ├─ Cloud (Nextcloud)                                    │
│  ├─ Apps (Syncthing, Tabby, Epic Games)                 │
│  ├─ Home Automation (Home Assistant)                    │
│  └─ Monitoring (Planned: Prometheus, Grafana)           │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│  Storage Layer (UGREEN NAS)                              │
│  ├─ Docker volumes                                       │
│  ├─ Media libraries                                      │
│  ├─ Configuration backups                                │
│  └─ File sync storage                                    │
└──────────────────────────────────────────────────────────┘
```

## Infrastructure Highlights

- **Hardware Transcoding**: Intel Alder Lake iGPU (QuickSync) for efficient media transcoding
- **Network Management**: UniFi for VLANs and network segmentation
- **Security**: Fail2ban, Cloudflare WAF, Let's Encrypt SSL
- **DNS**: AdGuard Home for local DNS and ad-blocking
- **Smart Home**: Home Assistant with Z-Wave/Zigbee integration

## Quick Navigation

### ⚡ [Quick Reference](quick-reference.md)

Fast access to service URLs, common commands, and troubleshooting guides.

### 📱 [Applications](apps/index.md)

General apps and utilities:

- [Syncthing](apps/syncthing.md) - File synchronization
- [Tabby](apps/tabby.md) - AI coding assistant
- [Epic Games](apps/epicgames.md) - Free games auto-claimer

### 🎬 [Media Server](media/index.md)

Streaming and entertainment:

- [Jellyfin](media/jellyfin.md) - Media streaming with hardware transcoding
- *arr stack (coming soon)

### 🏠 [Home Assistant](homeassistant/index.md)

Smart home automation and device control

### ☁️ [Cloud Services](cloud/index.md)

Self-hosted cloud storage:

- [Nextcloud](cloud/nextcloud.md) - File sync and collaboration

### 🔄 [Proxy & SSL](proxy/index.md)

- Reverse proxy configuration
- Cloudflare DDNS and DDoS protection
- SSL/TLS certificate management

### 💾 [Storage & Backups](storage/index.md)

- [Backup strategies](storage/backups.md)
- NAS configuration (coming soon)

### 📊 [Monitoring](monitoring/index.md)

*Under construction* - Metrics, dashboards, and alerting

### 🔒 [Security](security/index.md)

- [Fail2ban](security/fail2ban.md) - Brute-force protection
- Cloudflare WAF

### 🌐 [Networking](networking/index.md)

- UniFi network management
- AdGuard Home DNS
- VLANs and subnets

### 💻 [Hardware](hardware/index.md)

- Server specifications
- Intel Alder Lake compute
- Z-Wave/Zigbee adapters
- Network equipment

---

## About

This homelab serves as a learning environment and self-hosted infrastructure for personal services, automation, and media.

Built with [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) and deployed via GitHub Pages.
