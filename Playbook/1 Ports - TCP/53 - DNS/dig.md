---
tags:
  - tool
  - dns
---
# dig

Enumerate DNS

## Capabilities

```bash
# Query records
dig any @$IP $DOMAIN
dig a @$IP $DOMAIN

# Reverse lookup
dig -x $IP

# Attempt a zone transfer
dig axfr @$IP
dig axfr @$IP $DOMAIN
```

Notes: Add `+short` to get concise output. Sometimes `ANY` requests are blocked to prevent DoS and all record types need to be enumerated manually.
