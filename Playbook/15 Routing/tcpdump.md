---
tags:
  - routing
---
# tcpdump

View traffic

## Capabilities

```bash
# Listen for tcp traffic coming into the tun0 interface on port 8080
sudo tcpdump -nvvvXi tun0 tcp port 8080

# Listen for udp traffic coming into the ens192 interface on port 53
sudo tcpdump -i ens192 udp port 53
```
