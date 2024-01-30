---
tags:
  - sqlite
---
# sqlite3

Interact with `sqlite` databases

## Capabilities

### Open Database

```bash
sqlite3 db.sqlite3
```

Note: SQLite databases are just files, which is why SQLite has no built-in user authentication mechanism. Anyone with read permissions has access to the database

### Enumerate

```sqlite
.tables
.schema tablename
SELECT * FROM tablename;
```