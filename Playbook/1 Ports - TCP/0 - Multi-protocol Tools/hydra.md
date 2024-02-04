---
tags:
  - tool
  - brute_forcing
---
# hydra

Brute force services

## Capabilities

```bash
# Brute force protocols
hydra -l username -P /usr/share/wordlists/rockyou.txt -s 2222 ssh://$IP -f
hydra -L /usr/share/wordlists/dirb/others/names.txt -p 'password' rdp://$IP -f
hydra -L /usr/share/wordlists/dirb/others/names.txt -p 'password' ftp://$IP -f

# Brute force basic auth (401)
hydra -l username -P /usr/share/wordlists/rockyou.txt $IP http-get -f

# Brute force HTTP post request
hydra -l username -P /usr/share/wordlists/rockyou.txt $IP http-post-form '/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid' -f
```

**Note:** `L` and `P` are used for username and password respectively, lowercase either of them to specify a single value

### Wordlists

```bash
# Usernames
/usr/share/wordlists/dirb/others/names.txt # 8607 lines
/usr/share/seclists/Usernames/Names/names.txt # 10177 lines

# Passwords (short)
/usr/share/seclists/Passwords/2020-200_most_used_passwords.txt # 197 lines

# Passwords (long)
/usr/share/wordlists/rockyou.txt # 14344392 lines
```