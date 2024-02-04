# Methodology

## Connect

```bash
# Connect with credentials
impacket-mssqlclient $DOMAIN/username:password@$IP

# Force NTLM authentication
impacket-mssqlclient $DOMAIN/username:password@$IP -windows-auth
```

## Enumerate Database

```mysql
# Check version
SELECT @@version;

# List available databases
SELECT name FROM sys.databases;

# Enumerate databases
SELECT * FROM example_db.information_schema.tables;
SELECT * FROM example_db.dbo.example_table;

# Enumerate system users
SELECT * FROM master.dbo.sysusers;
```
