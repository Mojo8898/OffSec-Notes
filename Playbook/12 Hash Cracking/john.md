---
tags:
  - tool
  - hash_cracking
---
# john

Crack hashes (slower than hashcat)

## Capabilities

```bash
# Crack a hash
john --wordlist=/usr/share/wordlists/rockyou.txt hash

# Crack a hash with a rule list
john --wordlist=/usr/share/wordlists/rockyou.txt --rules=exampleRules hash
```

To use a hashcat rule file, prepend a compatibility line and append it to `/etc/john/john.conf`

**Contents of example.rules**

```
[List.Rules:exampleRules]
c $1 $3 $7 $!
c $1 $3 $7 $@
c $1 $3 $7 $#
```

```bash
sudo sh -c 'cat /home/kali/oscp/course/password_attacks/rule >> /etc/john/john.conf'
```
