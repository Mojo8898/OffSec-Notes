---
tags:
  - tool
  - postgresql
---
# psql

Interact with `postgresql` databases

## Capabilities

```bash
# Login
psql -h 127.0.0.1 -U postgres

# List databases
\l

# Connect to a database
\c example_database

# List views and sequences for the connected database
\d

# Enumerate a table
select * from cwd_user;
```
