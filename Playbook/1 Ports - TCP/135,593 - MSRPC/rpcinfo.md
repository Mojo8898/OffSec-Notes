---
tags:
  - rpc
---
# rpcinfo

Enumerate available RPC services

## Capabilities

```bash
# Query domain
rpcinfo $DOMAIN
```

**Note:** RPC utilizes the protocol `rpcbind` on port 111 to serve clients an index of where to find various RPC services.
