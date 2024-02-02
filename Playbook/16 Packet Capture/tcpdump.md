---
tags:
  - tool
  - packet_capture
---
# tcpdump

View raw incoming traffic

## Capabilities

```bash
# Listen for incoming ICMP traffic (massively helpful for testing blind RCE)
sudo tcpdump -i tun0 icmp

# Listen for tcp traffic coming into the tun0 interface on port 8080
sudo tcpdump -nvvvXi tun0 tcp port 8080

# Listen for udp traffic coming into the ens192 interface on port 53
sudo tcpdump -i ens192 udp port 53
```
