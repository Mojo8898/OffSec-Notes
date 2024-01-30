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
dig any @10.10.10.10 offsec.local
dig a @10.10.10.10 offsec.local

# Reverse lookup
dig -x @10.10.10.10 10.10.10.10

# Attempt zone transfer
dig axfr @10.10.10.10
dig axfr @10.10.10.10 offsec.local
```

Notes: Add `+short` to get concise output. Sometimes `ANY` requests are blocked to prevent DoS and all record types need to be enumerated manually.
