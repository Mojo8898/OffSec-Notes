---
tags:
  - routing
---
# socat

Multipurpose relay

## Capabilities

```bash
# Forward incoming packets on port 2345 to 10.4.50.215:5432
socat -ddd TCP-LISTEN:2345,fork TCP:10.4.50.215:5432

# Forward incoming packets on port 2222 to 10.4.50.215:22
socat TCP-LISTEN:2222,fork TCP:10.4.50.215:22
```
