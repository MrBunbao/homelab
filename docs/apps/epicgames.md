# Epic Games Free Games Auto-Claimer

Automated Epic Games Store free-game claimer running in Docker.

## Overview

This container periodically checks for new free games and redeems them automatically under your Epic account.

**Image:** `ghcr.io/claabs/epicgames-freegames-node:latest`

## Container Configuration

**Container name:** `epicgames-freegames`
**Host Port:** `5081 → 3000`
**Config Path:** `/volume1/docker/epicgames-freegames/config/config.json`
**Schedule:** Runs every 6 hours (`0 0,6,12,18 * * *`)
**Time Zone:** `America/Denver`

## Docker Compose

```yaml
services:
  epicgames:
    image: ghcr.io/claabs/epicgames-freegames-node:latest
    container_name: epicgames-freegames
    volumes:
      - /path/to/config:/usr/app/config
    ports:
      - 5081:3000
    environment:
      - TZ=America/Denver
    restart: unless-stopped
```

## Configuration (config.json)

```json
{
  "runOnStartup": true,
  "cronSchedule": "0 0,6,12,18 * * *",
  "logLevel": "info",
  "testNotifiers": false,
  "webPortalConfig": {
    "baseUrl": "http://YOUR_IP:5081"
  },
  "accounts": [
    { "email": "your@email.com" }
  ],
  "notifiers": [
    {
      "type": "email",
      "smtpHost": "smtp.gmail.com",
      "smtpPort": 587,
      "secure": false,
      "emailSenderAddress": "[REDACTED]",
      "emailSenderName": "Epic Games Captchas",
      "emailRecipientAddress": "[REDACTED]",
      "auth": {
        "user": "[REDACTED]",
        "pass": "[REDACTED]"
      }
    }
  ]
}
```

## Device Authorization

When the container requires authentication, it prints a link:
```
http://YOUR_IP:5081/abcdef
```

Open that link **immediately** and complete Epic's device login.

## Troubleshooting

**JSON syntax error with Windows line endings:**
```bash
dos2unix /path/to/config/config.json
```

**Discord webhook errors:** Verify webhook URL and permissions.

## Update Procedure

```bash
docker pull ghcr.io/claabs/epicgames-freegames-node:latest
docker stop epicgames-freegames
docker rm epicgames-freegames
docker compose up -d epicgames-freegames
```
