---
tags:
  - tool
  - arp
  - host_discovery
---
# netdiscover

Discover hosts through active/passive ARP reconnaissance, cannot cross network boundaries such as VPNs

## Capabilities

```bash
# Scan a range of addresses
sudo netdiscover -i eth0 -r 192.168.0.0/16

# Only sniff ARP traffic
sudo netdiscover -i eth0 -p
```
