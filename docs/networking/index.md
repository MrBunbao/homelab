# Networking

Network configuration and infrastructure for the homelab.

## Components

- **UniFi Network** - Network management and VLANs
- **AdGuard Home** - DNS-based ad blocking and local DNS
- **Cloudflare** - External DNS, DDNS, and DDoS protection
- **Reverse Proxy** - Traefik/Caddy for service routing

## Network Topology

*Coming soon: network diagram*

## Subnets & VLANs

*Coming soon: VLAN configuration*

## DNS Configuration

### AdGuard Home

Local DNS server for:
- Ad blocking
- Custom DNS records for homelab services
- DNS-over-HTTPS (DoH)

### Cloudflare

External DNS records point to the public IP, protected by Cloudflare proxy.

## Port Forwarding

*Coming soon: port forwarding rules*
