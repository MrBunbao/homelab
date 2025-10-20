# Nextcloud

File sync and collaboration platform with All-in-One deployment.

## Docker Compose Configuration

```yaml
services:
  nextcloud:
    image: nextcloud/all-in-one:latest
    restart: always
    container_name: nextcloud-aio-mastercontainer
    volumes:
      - nextcloud_aio_mastercontainer:/mnt/docker-aio-config
      - /var/run/docker.sock:/var/run/docker.sock:ro
    ports:
      - 80:80
      - 8080:8080
    environment:
      - APACHE_PORT=11000
      - APACHE_IP_BINDING=0.0.0.0
      - SKIP_DOMAIN_VALIDATION=true
      - NEXTCLOUD_DATADIR=/mnt/ncdata

volumes:
  nextcloud_aio_mastercontainer:
    name: nextcloud_aio_mastercontainer
```

## WebDAV Access

```
https://cloud.baolabs.io/remote.php/dav/files/admad/
```

### Windows Drive Mapping

```cmd
net use Z: https://cloud.baolabs.io/remote.php/dav/files/admad/ /user:admad
```

## Cloudflare DNS Integration

For Let's Encrypt SSL with Cloudflare DNS validation:

- API token: [REDACTED]
- Used for automatic certificate renewal

## Security

Protected with [Fail2ban](../security/fail2ban.md) for brute-force protection.
