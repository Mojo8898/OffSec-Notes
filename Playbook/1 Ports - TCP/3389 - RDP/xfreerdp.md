---
tags:
  - tool
  - rdp
---
# xfreerdp

Connect to Windows machines via RDP

## Capabilities

```bash
# Connect to machine (use /cert-ignore to ignore self-signed certificates)
xfreerdp /u:stephanie /p:'LegmanTeamBenzoin!!' /d:corp.com /v:192.168.196.75
xfreerdp /cert-ignore /u:jeff /d:corp.com /p:HenchmanPutridBonbon11 /v:192.168.50.75

# Also share a directory in the connection (this can break connections sometimes)
xfreerdp /u:drbrown /p:'chr!$br0wn' /v:10.10.11.241 /drive:shared,$(pwd)
```

**Note:** `/drive:shared,$(pwd)` shares the current working directory on your attack box, discoverable via `This PC` in `File Explorer`
