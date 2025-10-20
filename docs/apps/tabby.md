# Tabby

Self-hosted AI coding assistant for code completion and chat.

## Overview

Tabby provides GitHub Copilot-like code completions using open-source models running on your own hardware.

## GitHub OAuth Configuration

For VSCode extension authentication:

- **Client ID:** [REDACTED]
- **Client Secret:** [REDACTED]
- **Gateway Auth Token:** [REDACTED]

## Access

- Web UI: `http://TABBY_IP:PORT`
- API endpoint for VSCode extension

## Docker Compose Configuration

```yaml
services:
  tabby:
    image: tabbyml/tabby:latest
    container_name: tabby
    volumes:
      - /path/to/tabby/data:/data
    ports:
      - 8080:8080
    environment:
      - TABBY_MODEL=StarCoder-1B
    restart: unless-stopped
    deploy:
      resources:
        reservations:
          devices:
            - driver: nvidia
              count: 1
              capabilities: [gpu]
```

## VSCode Extension Setup

1. Install the Tabby extension from the marketplace
2. Configure endpoint URL
3. Authenticate with GitHub OAuth
