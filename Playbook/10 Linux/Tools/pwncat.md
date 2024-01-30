---
tags:
---
# pwncat

Automate reverse shell connections

## Capabilities

```bash
pwncat-cs

# Reverse shell
pwncat-cs -lp 9001

# Bind shell
pwncat-cs 192.168.1.1 9001

# List sessions
sessions

# Linux listener


# Windows listener
listen --platform windows 9001
sessions 0

# Upload file (local mode)
upload linpeas.sh


```

Drop into a session with `Ctrl + d` (toggle between `local` and `remote` mode)

Prefix a command with the word `local` inside a shell to run commands locally

If you need to send `Ctrl + d` or `Ctrl + k` to the target, prefix with `Ctrl + k`

