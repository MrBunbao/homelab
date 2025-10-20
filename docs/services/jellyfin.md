# Jellyfin

Media server for streaming movies, TV shows, and music.

## Hardware Transcoding

### GPU Information

```bash
lspci -nn | grep -Ei "3d|display|vga"
```

Output:
```
00:02.0 VGA compatible controller [0300]: Intel Corporation
Alder Lake-UP3 GT1 [UHD Graphics] [8086:46b3] (rev 0c)
```

### Intel QuickSync Configuration

For hardware-accelerated transcoding on Intel Alder Lake integrated graphics:

1. Pass through `/dev/dri` to the container
2. Ensure the container user has access to the `render` and `video` groups
3. Enable Intel QuickSync in Jellyfin admin dashboard

## Docker Compose Example

```yaml
services:
  jellyfin:
    image: jellyfin/jellyfin:latest
    container_name: jellyfin
    user: 1000:1000
    network_mode: host
    volumes:
      - /path/to/config:/config
      - /path/to/cache:/cache
      - /path/to/media:/media
    devices:
      - /dev/dri/renderD128:/dev/dri/renderD128
      - /dev/dri/card0:/dev/dri/card0
    restart: unless-stopped
```
