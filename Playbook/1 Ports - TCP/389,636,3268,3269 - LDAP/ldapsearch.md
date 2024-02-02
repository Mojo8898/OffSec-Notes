---
tags:
  - active_directory
---
# ldapsearch

Query LDAP

## Capabilities

```bash
# Check anonymous authentication
ldapsearch -x -H ldap://support.htb

# Provide naming contexts for future queries
ldapsearch -x -H ldap://support.htb -s base namingcontexts

# Query LDAP
ldapsearch -x -H ldap://support.htb -b 'DC=support,DC=htb'

# Query LDAP with authentication
ldapsearch -x -H ldap://support.htb -D 'support\ldap' -w 'nvEfEK16^1aM4$e7AclUf8x$tRWxPWO1%lmz' -b 'DC=support,DC=htb'
```

The following response means you need authentication

```
In order to perform this operation a successful bind must be completed on the connection
```
