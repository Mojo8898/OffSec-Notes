---
tags:
  - tool
  - ftp
---
# ftp

Connect via FTP

## Capabilities

```bash
# Connect, anonymous authentication - anonymous:a
ftp $IP
ftp -A $IP

# Browser connection
firefox ftp://username:password@$IP

# Download files
wget -m ftp://username:password@$IP
wget -m --no-passive ftp://username:password@$IP
```

### Session Commands

```bash
# Swap between active and passive mode, useful when you receive the response: "229 Entering Extended Passive Mode (|||60561|)"
passive

# Swap between binary and ASCII (binary required when uploading binaries)
binary
ascii

# List all files
dir

# Download file(s)
get example.txt
mget *.txt

# Upload file(s)
put example.txt
mput *.txt

# Delete file(s)
delete example.txt
mdelete *.txt

# Make directories
mkdir example_dir

# Navigate filesystem
pwd
cd example_dir

# Open shell
!
```
