---
tags:
---
# smbclient

Interact with SMB

## Capabilities

```bash
# List shares
smbclient -L 10.10.10.10

# Access a share
smbclient //10.10.10.10/share

# Upload a file
smbclient //192.168.50.195/share -c 'put config.Library-ms'
```

### Interacting with a share

```bash
# Download all files in the current share
prompt
mget *
```
