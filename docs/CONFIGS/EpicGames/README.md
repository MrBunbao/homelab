# 🕹️ Epic Games Free Games Auto-Claimer (Docker)

Automated Epic Games Store free-game claimer running on UGREEN NAS.
This container periodically checks for new free games and redeems them automatically under your Epic account.
Built from [ghcr.io/claabs/epicgames-freegames-node](https://github.com/claabs/epicgames-freegames-node).

---

## 📦 Container Information

**Container name:** `epicgames-freegames`
**Image:** `ghcr.io/claabs/epicgames-freegames-node:latest`
**Host Port:** `5081 → 3000`
**Config Path:** `/volume1/docker/epicgames-freegames/config/config.json`
**Schedule:** Runs every 6 hours (`0 0,6,12,18 * * *`)
**Time Zone:** `America/Denver`

---

## ⚙️ Working Configuration (config.json)

```json
{
  "runOnStartup": true,
  "cronSchedule": "0 0,6,12,18 * * *",
  "logLevel": "info",
  "testNotifiers": false,
  "webPortalConfig": {
    "baseUrl": "http://10.10.10.10:5081"
  },
  "accounts": [
    { "email": "me@andydao.net" }
  ],
  "notifiers": [
    {
      "type": "email",
      "smtpHost": "smtp.gmail.com",
      "smtpPort": 587,
      "secure": false,
      "emailSenderAddress": "andydao10@gmail.com",
      "emailSenderName": "Epic Games Captchas",
      "emailRecipientAddress": "me@andydao.net",
      "auth": {
        "user": "andydao10@gmail.com",
        "pass": "gccwmaazcbsnpbrw"
      }
    },
    {
      "type": "discord",
      "webhookUrl": "https://discord.com/api/webhooks/XXXXXXXX/XXXXXXXXXXXXXXXXXXXXXX"
    }
  ]
}
```

---

## 🔑 Device Authorization

When the container requires authentication, it prints a link such as:

```
http://10.10.10.10:5081/abcdef
```

Open that link in your browser **immediately** and complete Epic’s device login.
Afterward, it stores a device token and won’t prompt again until it expires.

---

## 🔁 Update Procedure

Pull the latest version and restart:

```bash
docker pull ghcr.io/claabs/epicgames-freegames-node:latest
docker stop epicgames-freegames
docker rm epicgames-freegames
docker run -d   -v /volume1/docker/epicgames-freegames/config:/usr/app/config   -p 5081:3000   --name epicgames-freegames   ghcr.io/claabs/epicgames-freegames-node:latest
```

Alternatively, if using Compose or Portainer, redeploy the service after pulling the image.

---

## 🧠 Maintenance Commands

View logs live:
```bash
docker logs -f epicgames-freegames
```

Inspect version / image ID:
```bash
docker inspect --format '{{.Image}}' epicgames-freegames
docker images ghcr.io/claabs/epicgames-freegames-node
```

Force-run manually (outside cron):
```bash
docker restart epicgames-freegames
```

Check container health or port binding:
```bash
docker ps --format 'table {{.Names}}	{{.Image}}	{{.Ports}}'
```

---

## 🧩 Troubleshooting

**If you see:**
`SyntaxError: JSON5: invalid character '"'` → The JSON file was saved with Windows line endings. Run:
```bash
dos2unix /volume1/docker/epicgames-freegames/config/config.json
```

**If you see:**
`ERR_BAD_REQUEST` from Discord → your webhook URL is invalid or missing permissions.

---

## ✅ Current State Summary
- Container runs correctly on Alpine.
- Cron schedule executes every 6 hours.
- Email notifier functional.
- Discord optional.
- No parsing or notifier test errors.

---

_Authored for Baolabs NAS, 2025-10-08._
