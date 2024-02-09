## AS-REP Roasting

Targets user accounts in an Active Directory environment with the "Do not require Kerberos preauthentication" setting enabled. This allows us to target any known user without prior authentication.

Perform remotely with [GetNPUsers](../../14%20Impacket%20Tools/GetNPUsers.md)

Perform locally with [Rubeus](../0%20Tools/Local/Rubeus.md)

## Kerberoasting

Targets service accounts in an Active Directory environment as an authenticated (but low privilege) user. This is done by requesting a service ticket from the TGS which is encrypted with the SPN's password hash. We can then crack the hash offline.

SPN format:

```bash
# Format
<service class>/<host>:<port>

# Examples
HTTP/web04.corp.com:80
```

Perform remotely with [GetUserSPNs](../../14%20Impacket%20Tools/GetUserSPNs.md)

Perform locally with [Rubeus](../0%20Tools/Local/Rubeus.md)
