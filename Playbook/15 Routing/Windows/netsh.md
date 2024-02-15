---
tags:
  - tool
  - routing
---
# netsh

Route traffic in Windows and interact with Windows firewalls

## Capabilities

```bash
# Listen on 192.168.50.64:2222 and forward traffic to 10.4.50.215:22
netsh interface portproxy add v4tov4 listenport=2222 listenaddress=$TARGET_IP connectport=22 connectaddress=$INTERNAL_IP

# Show all proxy configurations
netsh interface portproxy show all

# Check inbound/outbound firewall rules
netsh advfirewall firewall show rule name=all dir=in
netsh advfirewall firewall show rule name=all dir=out

# Add firewall rule to allow the previous port forward example
netsh advfirewall firewall add rule name="port_forward_ssh_2222" protocol=TCP dir=in localip=192.168.50.64 localport=2222 action=allow

# Delete firewall rule
netsh advfirewall firewall delete rule name="port_forward_ssh_2222"

# Delete port forward
netsh interface portproxy del v4tov4 listenport=2222 listenaddress=192.168.50.64
```
