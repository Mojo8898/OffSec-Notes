---
tags:
  - tool
  - mssql
---
# impacket-mssqlclient

TDS client implementation (SSL supported).

## Capabilities

```bash
# Connect to MSSQL database
impacket-mssqlclient $DOMAIN/username:password@$IP

# Connect to MSSQL database forcing NTLM authentication
impacket-mssqlclient $DOMAIN/username:password@$IP -windows-auth
```
