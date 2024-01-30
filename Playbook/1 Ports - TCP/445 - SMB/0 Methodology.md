# Methodology

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
```
