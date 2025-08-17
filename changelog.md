# Changelog

This document tracks changes, fixes, and updates I’ve made to my homelab environment.  
Format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) style with dates and sections.

---

## [2025-08-17] - DNS, Traefik & NAS Reverse Proxy

### Added

- Created Traefik dynamic config (`/etc/traefik/conf.d/nas.yaml`) to expose `nas.baolabs.io` → `10.7.7.6:9443`.
- Added `serversTransport` with `insecureSkipVerify: true` to allow proxying NAS UI with self-signed certs.
- Configured AdGuard Home DNS rewrites for:
  - `nas.baolabs.io` → `10.77.77.204`
  - Planned: `docs`, `adguard2`, `linkstack`, `proxmox`, `scrypted`, `portainer`, `nvr`, `traefik`.
- Created/updated `acme.json` storage file for Let’s Encrypt certs at `/etc/traefik/ssl/acme.json`.

### Changed

- Fixed Traefik `certResolver` mismatch (`cloudflare` → `letsencrypt`).
- Corrected Cloudflare API token environment variables for Traefik service:
  - Added `CF_DNS_API_TOKEN` and `CF_API_TOKEN` to systemd drop-in override.
  - Removed unused `[REDACTED_TOKEN]` and `CF_API_EMAIL`.

### Fixed

- Resolved SSL certificate errors caused by misconfigured certResolver and missing Cloudflare DNS API token.
- Eliminated Cloudflare 404 errors for `nas.baolabs.io` by ensuring Traefik router rules matched hostnames.
- Corrected AdGuard split-DNS so LAN clients resolve `nas.baolabs.io` internally instead of hairpinning through Cloudflare.

---

## How to Update

1. Add new entries under today’s date when making changes.  
2. Use **Added / Changed / Fixed / Removed** categories.  
3. Include file paths (configs, systemd units) and domain names affected.  
4. Commit to your GitHub `homelab` repo after major changes.

---

should this be here? Updated to: 73.65.173.192
