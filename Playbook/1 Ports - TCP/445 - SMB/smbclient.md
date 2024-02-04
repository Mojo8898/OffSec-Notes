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

### Session Commands

```bash
# List files
dir

# Download file(s)
get example.txt
mget *.txt

# Upload file(s)
put example.txt
mput *.txt

# Delete file(s)
del example.txt
mdel *.txt

# Make directories
mkdir example_dir

# Navigate filesystem
pwd
cd example_dir

# Download all files in the current share
mask ""
recurse
prompt
mget *
```
