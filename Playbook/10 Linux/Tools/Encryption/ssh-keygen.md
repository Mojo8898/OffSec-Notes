---
tags:
  - ssh
---
# ssh-keygen

Generate OpenSSH keys

## Capabilities

```bash
# Generate a key pair
ssh-keygen -t RSA -b 4096
```

Note

- Copy public key to `authorized_keys` with `cat id_rsa.pub >> authorized_keys` on target machine to connect to it with `id_rsa`
- `.ssh` directory should have the permissions `700` and all keys should have the permissions `600`