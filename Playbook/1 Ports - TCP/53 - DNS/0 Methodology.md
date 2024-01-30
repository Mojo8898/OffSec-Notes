# Methodology

```bash
# Query records
dig any @$IP offsec.local
dig a @10.10.10.10 offsec.local

# Reverse lookup
dig -x @10.10.10.10 10.10.10.10

# Attempt a zone transfer
dig axfr @10.10.10.10 offsec.local
```

Notes: Add `+short` to get concise output. Sometimes `ANY` requests are blocked to prevent DoS and all record types need to be enumerated manually.
