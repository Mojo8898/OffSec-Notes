---
tags:
  - tool
  - hash_cracking
---
# hashcat

Crack hashes

Reference: [example_hashes](https://hashcat.net/wiki/doku.php?id=example_hashes), make sure to remove escape characters from the hash if necessary (`\`)

## Capabilities

```bash
# Crack hash
hashcat -m 0 hash /usr/share/wordlists/rockyou.txt --force
hashcat -m 0 hashes/hash wordlists/rockyou.txt --force

# Crack hash with rule file
hashcat -m 0 hash /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force

# Check cracked hash, add --show to the end of the last command
hashcat -m 0 hash /usr/share/wordlists/rockyou.txt --force --show

# Benchmark
hashcat -b
```

Convert a variety of encryption types with `ENC2john` where `ENC` is some type of encryption such as `pfx`, `ssh`, `keepass` and more

### Custom Rule File

[Reference](https://hashcat.net/wiki/doku.php?id=rule_based_attack)

Given the following note left on a target

```
Dave's password list:

Window
rickc137
dave
superdave
megadave
umbrella

Note to myself:
New password policy starting in January 2022. Passwords need 3 numbers, a capital letter and a special character
```

We can create a rule file that capitalizes the first letter, adds the numbers `137` and a special character at the end. We will test only for the first 3 special characters on the keyboard (`!`, `@`, `#`) since they are likely more common

```
kali@kali:~/passwordattacks$ cat ssh.rule
c $1 $3 $7 $!
c $1 $3 $7 $@
c $1 $3 $7 $#
```

We can then create a wordlist from the previously used passwords

```
kali@kali:~/passwordattacks$ cat ssh.passwords
Window
rickc137
dave
superdave
megadave
umbrella
```

Lastly we can crack them with hashcat

```bash
hashcat -m 22921 ssh.hash ssh.passwords -r ssh.rule --force
```

Rule file that appends nothing, a "1" or a "!"

```
:
$1
$!
```
