---
tags:
  - tool
  - ssh
---
# scp

Copy files over SSH

## Capabilities

```bash
# Copy files from target to attack box
scp <user>@<remote-host>:<path> <file>

# Copy files from attack box to target
scp <file> <user>@<remote-host>:<path>
```

Specify `-r` for a directory