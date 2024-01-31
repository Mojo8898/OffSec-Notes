---
tags:
  - tool
  - web
  - fuzzing
---
# ffuf

Fuzz everything

## Capabilities

```bash
# VHost fuzzing
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u 'http://example.com' -H 'Host: FUZZ.example.com'

# Extension fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt -u 'http://example.com/indexFUZZ'

# Directory fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -u 'http://example.com/FUZZ'

# File fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -u 'http://example.com/FUZZ'

# Recursive directory fuzzing (last resort)
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u 'http://example.com/FUZZ' -ic -recursion --recursion-depth 1 -e .php

# GET parameter fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -u 'http://example.com?FUZZ=key'

# GET parameter value fuzzing
ffuf -w /usr/share/seclists/Fuzzing/special-chars.txt -u 'http://example.com?param=FUZZ'

# POST parameter fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -u 'http://example.com' -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded'

# FUZZ using a request copied from burp (helpful with json data)
ffuf -request search.req -request-proto http -w /usr/share/seclists/Usernames/Names/names.txt

# Same as previous example but using 2 wordlists to fuzz 2 values inside of request
# The nums.txt wordlist is used first as it is extremely short and we want it to be fully exhausted before moving to the next name
ffuf -request search.req -request-proto http -w nums.txt:F2,/usr/share/seclists/Usernames/Names/names.txt:F1

# Same as previous example except we are using an inline sequence command instead of having to create a wordlist before hand
# We use <() process substitution instead of $() command substitution to allow us to treat the output of the command as a file
ffuf -request search.req -request-proto http -w <(seq 0 7):F2,/usr/share/seclists/Usernames/Names/names.txt:F1

# Use burp proxy to intercept and view request before sending it
ffuf -w /usr/share/seclists/Fuzzing/special-chars.txt -u 'http://example.com?param=FUZZ' -x http://localhost:8080

# Sub-domain fuzzing (public DNS records, bad practice)
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u 'http://FUZZ.example.com'
```

**Note:**

- Use lowercase wordlists when fuzzing case-insensitive web servers (common with Windows)
- If initial directory scan yields nothing and you have no other leads, use a list for the specific technology you are encountering.

**My `/home/kali/.config/ffuf/ffufrc`**:

```
[general]
    colors = true
    threads = 50
```

## Wordlists

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
/usr/share/seclists/Discovery/Web-Content/web-extensions.txt # 41 lines

# Special characters
/usr/share/seclists/Fuzzing/special-chars.txt

# All characters and symbols
/usr/share/seclists/Fuzzing/alphanum-case-extra.txt

# Usernames
/usr/share/seclists/Usernames/Names/names.txt # 10177 lines
```

**Note:** `directory-list-2.3` contains comments and requires `-ic` to ignore comments in `ffuf`
