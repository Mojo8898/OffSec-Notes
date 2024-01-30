# Wordlists

## Web Fuzzing

Use lowercase lists when initial scans reveal fuzzing to not be case sensitive (typical with Windows hosts).

```bash
# Directory/File Fuzzing (general), Add extensions if no initial leads or looking for an endpoint
/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt # 87664 lines
/usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-small.txt

/usr/share/seclists/Discovery/Web-Content/directory-list-2.3-medium.txt # 220560 lines
/usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-medium.txt

# Directory Fuzzing (targeted)
/usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt # 30000 lines
/usr/share/seclists/Discovery/Web-Content/raft-medium-directories-lowercase.txt

# File Fuzzing (targeted)
/usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt # 17129 lines
/usr/share/seclists/Discovery/Web-Content/raft-medium-files-lowercase.txt

# Vhosts/subdomains
/usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt
/usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt

# Extensions

```

Note: `directory-list-2.3` contains comments and requires `-ic` to ignore comments in `ffuf`

## Brute Forcing

```bash
# Special characters
/usr/share/seclists/Fuzzing/special-chars.txt

# All characters and symbols
/usr/share/seclists/Fuzzing/alphanum-case-extra.txt

# Usernames
/usr/share/seclits/Usernames/Names/names.txt

# Cracking hashes
/usr/share/wordlists/rockyou.txt

# Attacking AD credentials with username list
/usr/share/seclists/Passwords/2020-200_most_used_passwords.txt

# SNMP community strings
/usr/share/seclists/Discovery/SNMP/common-snmp-community-strings.txt
```
