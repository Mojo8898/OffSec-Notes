---
tags:
  - tool
  - smb
---
# impacket-smbclient

Connect via SMB

## Capabilities

```bash
# Connect
impacket-smbclient $DOMAIN/$USERNAME:$PASSWORD@$IP -dc-ip $DC_IP

# Enumerate shares
shares
use $SHARE
ls
mget *
```
