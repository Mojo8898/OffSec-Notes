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
# Directory fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u 'http://analysis.htb/FUZZ' -ic

# Discover endpoints under 403 vhost (used lowercase list as previous scans revealed the website to be case insensitive)
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-small.txt -u 'http://internal.analysis.htb/FUZZ' -ic -recursion --recursion-depth 1 -e .php

# Extension fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/web-extensions.txt -u 'http://internal.analysis.htb/dashboard/indexFUZZ'

# Page fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u http://example.com/FUZZ.php -ic

# Sub-domain fuzzing (public DNS records)
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://FUZZ.example.com

# VHost fuzzing
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u http://example.com -H 'Host: FUZZ.example.com'

# Get request fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -u http://example.com?FUZZ=key

# POST Request Fuzzing
ffuf -w /usr/share/seclists/Discovery/Web-Content/burp-parameter-names.txt -u http://example.com -X POST -d 'FUZZ=key' -H 'Content-Type: application/x-www-form-urlencoded'
```

Fuzz special characters where `search.req` is a GET request copied to file from burp

```bash
ffuf -request search.req -request-proto http -w /usr/share/seclists/Fuzzing/special-chars.txt
```

Output can be filtered with `-fx` and matched with `-mx` (replacing `x` with `s` for specifying size for example)

If initial directory scan yields nothing, use a list for the specific technology you are encountering.

Run additional, tailored scans based on the websites backend framework, such as Spring Boot: `/usr/share/seclists/Discovery/Web-Content/spring-boot.txt`

Use `/usr/share/seclists/Discovery/Web-Content/directory-list-lowercase-2.3-small.txt` (lowercase) against servers that are case-insensitive (common with Windows servers)