# Methodology

```bash
# Add domain to /etc/hosts if necessary
echo "$IP example.com" | sudo tee -a /etc/hosts

# Fuzz vhosts
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-5000.txt -u 'http://example.com' -H 'Host: FUZZ.example.com'

# ENTIRELY enumerate the web page
firefox http://example.com &

# Briefly fuzz common extensions in the browser
/index.php
/index.htm
/index.html
/index.asp
/index.aspx

# Briefly check source code (ignore css/js for now)
Ctrl + u

# Any abnormal clicks should be investigated manually with burp

# Imediately jump to any discovered vhosts, first adding them to /etc/hosts
firefox http://dev.example.com &

# If the vhost is blocked or redirected (403, 302, etc.), Start fuzzing for endpoints
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -u 'http://dev.example.com/FUZZ'
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -u 'http://dev.example.com/FUZZ'

# If any suspicious directories are discovered, fuzz them
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-files.txt -u 'http://dev.example.com/suspicious_dir/FUZZ'
ffuf -w /usr/share/seclists/Discovery/Web-Content/raft-medium-directories.txt -u 'http://dev.example.com/suspicious_dir/FUZZ'

# If still no leads, try a bigger subdomain list
ffuf -w /usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt -u 'http://example.com' -H 'Host: FUZZ.example.com'

# If still no leads, start a recursive scan, prioritizing discovered vhosts
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u 'http://dev.example.com/FUZZ' -ic -recursion --recursion-depth 1 -e .php
ffuf -w /usr/share/seclists/Discovery/Web-Content/directory-list-2.3-small.txt -u 'http://example.com/FUZZ' -ic -recursion --recursion-depth 1 -e .php
```
