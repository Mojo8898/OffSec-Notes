---
tags:
  - tool
  - routing
---
# ssh

Connect to linux machines

## Capabilities

```bash
# Start SSH service to create reverse port forwards
sudo systemctl start ssh

# Reverse individual port forward 
ssh -N -R 127.0.0.1:2345:10.4.50.215:5432 kali@192.168.118.4

# Reverse dynamic port forward
ssh -N -R 1080 kali@192.168.118.4
```
