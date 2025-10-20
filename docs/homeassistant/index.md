# Home Assistant

Open-source home automation platform for controlling smart devices.

## Z-Wave USB Adapter

### Nabu Casa ZWA-2 (Zigbee + Z-Wave)

**Device Path:** `/dev/ttyACM0`

**Device ID:** `/dev/serial/by-id/usb-Nabu_Casa_ZWA-2_80B54EE5C54C-if00`

**Attributes:**
```
Subsystem: tty
Device path: /dev/ttyACM0
ID: /dev/serial/by-id/usb-Nabu_Casa_ZWA-2_80B54EE5C54C-if00
ID_MODEL: ZWA-2
ID_SERIAL: Nabu_Casa_ZWA-2_80B54EE5C54C
ID_USB_DRIVER: cdc_acm
ID_VENDOR: Nabu_Casa
```

## Docker Compose Configuration

```yaml
services:
  homeassistant:
    image: ghcr.io/home-assistant/home-assistant:stable
    container_name: homeassistant
    privileged: true
    restart: unless-stopped
    environment:
      - TZ=America/Denver
    volumes:
      - /path/to/config:/config
    devices:
      - /dev/ttyACM0:/dev/ttyACM0
    network_mode: host
```

**Note:** Pass through the Z-Wave USB device using the stable `/dev/serial/by-id/` path to avoid issues if device enumeration changes.
