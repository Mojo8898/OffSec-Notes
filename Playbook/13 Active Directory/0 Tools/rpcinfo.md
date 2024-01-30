---
tags:
  - rpc
---
# rpcinfo

Enumerate available RPC services

## Capabilities

### Query RPC Server

```bash
rpcinfo clicker.htb
```

Note: RPC utilizes the protocol `rpcbind` on port 111 to serve clients an index of where to find various RPC services.