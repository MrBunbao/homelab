# Quick Reference

Fast access to common commands, URLs, and configurations.

## Service URLs

### Internal Access (LAN)

| Service | URL | Description |
|---------|-----|-------------|
| NAS Web UI | `https://nas.baolabs.io` | UGREEN NAS management |
| Nextcloud | `https://cloud.baolabs.io` | File sync and collaboration |
| Jellyfin | `http://[INTERNAL_IP]:8096` | Media streaming |
| Syncthing | `http://[INTERNAL_IP]:8384` | File synchronization |
| Tabby | `http://[INTERNAL_IP]:8080` | AI coding assistant |
| Home Assistant | `http://[INTERNAL_IP]:8123` | Smart home control |
| AdGuard Home | `http://[INTERNAL_IP]:3000` | DNS and ad-blocking |
| Traefik Dashboard | `http://[INTERNAL_IP]:8080` | Reverse proxy dashboard |

### External Access (WAN)

All external services are proxied through Cloudflare and Traefik with SSL:
- `https://nas.baolabs.io`
- `https://cloud.baolabs.io`
- `https://docs.baolabs.io` (this site)

## Common Commands

### Docker Management

```bash
# View running containers
docker ps

# View all containers (including stopped)
docker ps -a

# View container logs
docker logs [container_name]
docker logs -f [container_name]  # Follow logs

# Restart a container
docker restart [container_name]

# Stop/start a container
docker stop [container_name]
docker start [container_name]

# Remove a container
docker rm [container_name]

# View Docker Compose services
docker compose ps

# Restart Docker Compose stack
docker compose restart

# Rebuild and restart
docker compose up -d --build
```

### System Monitoring

```bash
# Check system resources
htop
# or
top

# Disk usage
df -h

# Docker disk usage
docker system df

# Check memory
free -h

# Check temperatures
sensors

# Check service status
systemctl status [service_name]
```

### Networking

```bash
# Check open ports
sudo netstat -tulpn

# Test connectivity
ping [host]
curl -I https://[domain]

# DNS lookup
nslookup [domain]
dig [domain]

# Check routing
traceroute [host]
```

### Traefik Management

```bash
# Check Traefik status
systemctl status traefik

# Restart Traefik
sudo systemctl restart traefik

# View Traefik logs
sudo journalctl -u traefik -f

# Validate Traefik config
traefik validate /etc/traefik/traefik.yml
```

### Fail2ban

```bash
# Check Fail2ban status
sudo fail2ban-client status

# Check specific jail
sudo fail2ban-client status [jail_name]

# Unban an IP
sudo fail2ban-client set [jail_name] unbanip [IP]

# View banned IPs
sudo fail2ban-client banned
```

### Backup & Maintenance

```bash
# Backup Docker volumes
docker run --rm -v [volume_name]:/data -v $(pwd):/backup alpine tar czf /backup/backup.tar.gz /data

# Check for system updates (Ubuntu/Debian)
sudo apt update
sudo apt list --upgradable

# Update Docker images
docker compose pull
docker compose up -d

# Clean up Docker
docker system prune -a
```

## File Locations

### Configuration Files

| Component | Location |
|-----------|----------|
| Traefik Static Config | `/etc/traefik/traefik.yml` |
| Traefik Dynamic Configs | `/etc/traefik/conf.d/*.yaml` |
| Traefik SSL Certs | `/etc/traefik/ssl/acme.json` |
| Docker Compose Files | `/opt/docker/[service]/docker-compose.yml` |
| Fail2ban Config | `/etc/fail2ban/jail.local` |
| Fail2ban Filters | `/etc/fail2ban/filter.d/` |

### Data & Storage

| Type | Location |
|------|----------|
| Docker Volumes | `/var/lib/docker/volumes/` |
| Media Library | `/mnt/media/` or NAS mount |
| Backups | `/mnt/backups/` or NAS |
| Nextcloud Data | Docker volume or `/mnt/ncdata/` |

## Port Reference

### Common Service Ports

| Service | Port(s) | Protocol |
|---------|---------|----------|
| HTTP | 80 | TCP |
| HTTPS | 443 | TCP |
| SSH | 22 | TCP |
| Traefik Web | 8080 | TCP |
| Jellyfin | 8096 | TCP |
| Nextcloud AIO | 8080, 11000 | TCP |
| Syncthing UI | 8384 | TCP |
| Syncthing Sync | 22000 | TCP/UDP |
| Home Assistant | 8123 | TCP |
| AdGuard Home | 53, 3000 | TCP/UDP |

See the UGREEN NAS documentation for NAS-specific ports.

## Environment Variables

Common environment variables used across services:

```bash
# Timezone
TZ=America/Denver

# User/Group IDs (for file permissions)
PUID=1000
PGID=1000

# Cloudflare
CF_DNS_API_TOKEN=[YOUR_TOKEN]
CF_API_TOKEN=[YOUR_TOKEN]

# Nextcloud
NEXTCLOUD_DATADIR=/mnt/ncdata
```

Store actual values in `.env` files (gitignored).

## Quick Troubleshooting

### Service Won't Start

1. Check logs: `docker logs [container]` or `journalctl -u [service]`
2. Check port conflicts: `sudo netstat -tulpn | grep [port]`
3. Check disk space: `df -h`
4. Verify configuration syntax
5. Check file permissions

### SSL Certificate Issues

1. Check Traefik logs: `sudo journalctl -u traefik -f`
2. Verify DNS records point to correct IP
3. Check Cloudflare API token is valid
4. Verify cert resolver name matches config
5. Check `/etc/traefik/ssl/acme.json` permissions (600)

### Network Connectivity Issues

1. Check firewall rules: `sudo ufw status` or UniFi console
2. Verify DNS resolution: `nslookup [domain]`
3. Test internal connectivity: `ping [internal_ip]`
4. Check AdGuard Home rewrites
5. Verify VLAN configuration

### Container Keeps Restarting

1. Check logs for errors: `docker logs [container]`
2. Verify volume mounts exist and have correct permissions
3. Check resource limits (memory, CPU)
4. Verify environment variables are set
5. Test with `docker compose up` (without `-d`) to see real-time output

## Related Resources

- [Hardware Specifications](hardware/index.md)
- [Network Configuration](networking/index.md)
- [Security Best Practices](security/index.md)
- [Backup Strategies](storage/backups.md)
