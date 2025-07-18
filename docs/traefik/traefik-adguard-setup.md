
# 🧭 Reverse Proxy Setup with Traefik + Let's Encrypt + AdGuard DNS Rewrite

This guide documents how to expose internal services (e.g., `proxmox.baolabs.io`) via HTTPS using Traefik running in LXC, with DNS rewrites handled through AdGuard Home.

---

## 🛠️ Prerequisites

- Traefik is installed and running inside an LXC container on `10.77.77.204`.
- Your domain (e.g. `baolabs.io`) is managed by Cloudflare and Traefik is configured to issue Let's Encrypt certificates using the Cloudflare DNS challenge.
- AdGuard Home is active on your network and used as the primary DNS for clients.

---

## 🧱 Step 1: Add a DNS Rewrite in AdGuard Home

1. Open AdGuard Home and go to **Settings > DNS Settings > DNS Rewrites**.
2. Click **Add DNS Rewrite**.
3. Fill in:
   - **Domain name**: `proxmox.baolabs.io`
   - **IP address**: `10.77.77.7` (the actual internal IP of your service)
4. Click **Save**.

---

## 🔐 Step 2: Create the Traefik Config for the Service

In your Traefik container, create a new file at:

```
/etc/traefik/conf.d/proxmox.yaml
```

Paste the following content and adjust `Host`, `url`, and `service name` as needed:

```yaml
http:
  routers:
    proxmox:
      rule: "Host(`proxmox.baolabs.io`)"
      entryPoints:
        - websecure
      service: proxmox
      tls:
        certResolver: letsencrypt

    proxmox-redirect:
      rule: "Host(`proxmox.baolabs.io`)"
      entryPoints:
        - web
      service: dummy
      middlewares:
        - redirect-to-https

  middlewares:
    redirect-to-https:
      redirectScheme:
        scheme: https
        permanent: true

  services:
    proxmox:
      loadBalancer:
        servers:
          - url: "https://10.77.77.7:8006"
        passHostHeader: true
        serversTransport: insecureTlsTransport

    dummy:
      loadBalancer:
        servers:
          - url: "http://127.0.0.1"

  serversTransports:
    insecureTlsTransport:
      insecureSkipVerify: true
```

> 🔁 **Note:** You can duplicate this file format for any service. Just change:
> - The router name (`proxmox`) and service name (`proxmox`)
> - The `Host(...)`
> - The internal `url`

---

## ♻️ Step 3: Restart Traefik

After saving the YAML file, apply the changes:

```bash
docker restart traefik
# or if you're using systemd
systemctl restart traefik
```

---

## ✅ Step 4: Verify Access

Open your browser and visit:

```
https://proxmox.baolabs.io
```

Check that:
- It loads with a valid Let's Encrypt certificate.
- No internal error or 404 appears.

If issues arise, check logs:

```bash
docker logs -f traefik
# or
journalctl -u traefik -f
```

---

## 🧪 Template for New Services

To add any new service (e.g., `portainer.baolabs.io`), repeat:

1. Add DNS rewrite to point to its IP
2. Copy and modify the `.yaml` file with:
   - New `Host(...)`
   - Unique router/service name
   - Target container IP:PORT
3. Restart Traefik
4. Test via browser

---

## 📁 Folder structure reference

```bash
/etc/traefik/
├── traefik.yaml
├── conf.d/
│   ├── proxmox.yaml
│   ├── portainer.yaml
│   └── ...
└── dynamic/
    └── ...
```
