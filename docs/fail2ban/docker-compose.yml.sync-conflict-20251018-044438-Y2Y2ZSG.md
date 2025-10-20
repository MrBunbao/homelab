```
---
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
      - VERBOSITY=-vv #optional
    volumes:
      - /path/to/fail2ban/config:/config
      - /var/log:/var/log:ro
      - /var/www/logs/access.log:/remotelogs/nextcloud:ro #optional
      - /path/to/nginx/log:/remotelogs/nginx:ro #optional
      - /path/to/nzbget/log:/remotelogs/nzbget:ro #optional
      - /path/to/overseerr/log:/remotelogs/overseerr:ro #optional
      - /path/to/prowlarr/log:/remotelogs/prowlarr:ro #optional
      - /path/to/radarr/log:/remotelogs/radarr:ro #optional
      - /path/to/sabnzbd/log:/remotelogs/sabnzbd:ro #optional
      - /path/to/sonarr/log:/remotelogs/sonarr:ro #optional
      - /path/to/unificontroller/log:/remotelogs/unificontroller:ro #optional
      - /path/to/vaultwarden/log:/remotelogs/vaultwarden:ro #optional
    restart: unless-stopped
```
