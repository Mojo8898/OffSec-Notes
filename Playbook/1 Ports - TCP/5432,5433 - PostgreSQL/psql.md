---
tags:
  - tool
  - postgresql
---
# psql

Interact with `postgresql` databases

## Capabilities

```bash
# Connect with credentials
psql -h $IP -U username
```

### Session Commands

```mysql
# List databases
\l

# Connect to a database
\c example_database

# List views and sequences for the connected database
\d

# Enumerate a table
select * from cwd_user;
```
