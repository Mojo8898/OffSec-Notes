---
tags:
  - port
---
# 80 - http

## Enumeration

```bash
echo '10.129.34.163 searcher.htb' | sudo tee -a /etc/hosts
```

## Vulnerabilities

### RCE

![](Attachments/Pasted%20image%2020240119145632.png)

https://github.com/nikn0laty/Exploit-for-Searchor-2.4.0-Arbitrary-CMD-Injection