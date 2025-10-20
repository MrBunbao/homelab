# 🏠 Homelab Repository

Welcome to my Homelab repository! This project is designed to provide an overview of the tools, services, and infrastructure that power my homelab environment. Whether you're here for inspiration or to contribute improvements, you'll find everything neatly organized below. 😃

[![Stars](https://img.shields.io/github/stars/MrBunbao/homelab?style=for-the-badge)](https://github.com/MrBunbao/homelab/stargazers)
[![Last Commit](https://img.shields.io/github/last-commit/MrBunbao/homelab?style=for-the-badge)](https://github.com/MrBunbao/homelab/commits/main)
[![Issues](https://img.shields.io/github/issues/MrBunbao/homelab?style=for-the-badge)](https://github.com/MrBunbao/homelab/issues)
[![License](https://img.shields.io/github/license/MrBunbao/homelab?style=for-the-badge)](https://github.com/MrBunbao/homelab/blob/main/LICENSE)

- Website: https://docs.baolabs.io

## 💻 Features

- 📂 Organized directory structure for configs, docs, infra, and services
- 🐳 Docker Compose templates for common self‑hosted apps (Nextcloud, Jellyfin, Rustdesk, Wiki.js)
- ⚙️ Reverse proxy examples (Traefik, Caddy)
- 🛡️ DNS & Ad‑blocking setup (AdGuard Home, Cloudflare DDNS)
- 📈 Monitoring with Prometheus, Grafana, and Uptime Kuma
- 📝 Runbooks and troubleshooting notes for quick recovery

This repository organizes documentation, configs, and service stacks.

## 🔭 Overview

This repository acts as a central hub for documenting my homelab setup, including hardware configurations, software installations, network diagrams, and maintenance procedures. The goal is to create a living document that evolves as the homelab does.

## 📚 Documentation

Public docs are built with MkDocs Material and deployed to GitHub Pages:

- Architecture & Design: Diagrams and topology
- Installation Guides: Step-by-step deployment and configuration
- Usage Tips: Best practices and troubleshooting
- Change Log: Updates and improvements

🌐 Visit the site: https://docs.baolabs.io

---

## MkDocs

- Framework: MkDocs Material with "Edit on GitHub" enabled (via repo_url + edit_uri)

### Local development

```bash
source ./.venv/bin/activate
mkdocs serve -a 127.0.0.1:8000
```

### Directory layout

- docs/: public documentation (safe to publish)
- docs-private/: private docs with secrets (untracked, never commit)
- compose/: Docker Compose examples (sanitized)
- configs/: Config templates (sanitized)

### Safety

- Pre-commit with detect-secrets is enabled. Do not commit secrets.
- Keep any sensitive notes in docs-private/ only.
