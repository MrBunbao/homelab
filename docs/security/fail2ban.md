# Fail2ban

Intrusion prevention system that protects services from brute-force attacks.

## Docker Compose Configuration

```yaml
services:
  fail2ban:
    image: lscr.io/linuxserver/fail2ban:latest
    container_name: fail2ban
    cap_add:
      - NET_ADMIN
      - NET_RAW
    network_mode: host
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Etc/UTC
      - VERBOSITY=-vv
    volumes:
      - /path/to/fail2ban/config:/config
      - /var/log:/var/log:ro
      - /var/www/logs/access.log:/remotelogs/nextcloud:ro
    restart: unless-stopped
```

## Nextcloud Integration

### Log Path

Map the Nextcloud log directory as a read-only volume:
```yaml
- /var/www/logs/access.log:/remotelogs/nextcloud:ro
```

### Jail Configuration

Create `/config/fail2ban/jail.d/nextcloud.local`:

```ini
[nextcloud]
enabled = true
port = http,https
protocol = tcp
filter = nextcloud
logpath = /remotelogs/nextcloud
maxretry = 5
bantime = 3600
findtime = 600
```

### Filter

Create `/config/fail2ban/filter.d/nextcloud.conf`:

```ini
[Definition]
failregex = ^{"reqId":".*","remoteAddr":"<HOST>","app":"core".*"message":"Login failed:
            ^{"reqId":".*","remoteAddr":"<HOST>","app":"core".*"message":"Token login failed
ignoreregex =
```

## Monitoring

View banned IPs:
```bash
docker exec -it fail2ban fail2ban-client status
docker exec -it fail2ban fail2ban-client status nextcloud
```

Unban an IP:
```bash
docker exec -it fail2ban fail2ban-client set nextcloud unbanip <IP>
```
