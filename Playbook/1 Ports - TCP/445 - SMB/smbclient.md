---
tags:
---
# smbclient

Interact with SMB

## Capabilities

```bash
# List shares
smbclient -L //$IP -U 'username'

# Access a share
smbclient //$IP/share -U 'username'

# Upload a file
smbclient //$IP/share -c 'put example.txt'
```

### Interacting with a share

```bash
# Download all files in the current share
mask ""
recurse
prompt
mget *
```
