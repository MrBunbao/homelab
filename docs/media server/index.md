# Media Server

Media streaming and entertainment services.

## Services

- **[Jellyfin](jellyfin.md)** - Media server with Intel QuickSync hardware transcoding
- **Jellyseerr** - Request management system for movies and TV shows
- **Prowlarr** - Indexer manager and proxy for *arr applications
- **Radarr** - Movie collection manager and automation
- **Sonarr** - TV show collection manager and automation
- **Wizarr** - User invitation and onboarding system for Jellyfin

## Overview

The media stack provides a complete automation pipeline for streaming movies, TV shows, and music. Jellyfin serves as the core media server with hardware-accelerated transcoding on Intel Alder Lake integrated graphics.

Users can request content through Jellyseerr, which integrates with Radarr (movies) and Sonarr (TV shows) to automatically download and organize media. Prowlarr manages indexers across all *arr applications, providing centralized configuration. New users are onboarded through Wizarr, which handles invitations and account creation.
