---
tags:
  - sqlite
---
# sqlite3

Interact with `sqlite` databases

## Capabilities

```sqlite
-- Open database
sqlite3 db.sqlite3

-- Enumerate
.tables
.schema tablename
SELECT * FROM tablename;

-- Quit
.quit
```

**Note:** SQLite databases are just files, which is why SQLite has no built-in user authentication mechanism. Anyone with read permissions has access to the database
