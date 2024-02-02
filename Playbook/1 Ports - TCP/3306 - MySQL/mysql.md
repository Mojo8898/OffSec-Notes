---
tags:
  - tool
  - mysql
---
# mysql

Interact with `mysql` databases

## Capabilities

### Connection

```bash
# Connect locally
mysql -u root -p'password'

# Connect remotely
mysql -u 'username' -p'password' -h $IP
```

### Enumeration

```mysql
# Check version
select version();

# Check current database user
select system_user();

# Enumerate databases
show databases;
use <database>;

# Enumerate tables
show tables;
SELECT * FROM user;
SELECT user, session_token FROM user WHERE user = 'username';
```