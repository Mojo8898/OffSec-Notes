---
tags:
  - routing
---
# sshuttle

Route traffic over SSH

## Capabilities

```bash
# Connect to 192.168.50.63:2222, adding 10.4.50.0/24 and 172.16.50.0/24 to our routing tables which will be forwarded through the connection
sshuttle -r database_admin@192.168.50.63:2222 10.4.50.0/24 172.16.50.0/24
```

sshuttle removes the need for proxychains and automatically adds entries to the local routing table.