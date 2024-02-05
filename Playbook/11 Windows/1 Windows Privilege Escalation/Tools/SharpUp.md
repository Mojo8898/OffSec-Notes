---
tags:
  - tool
  - windows
  - privilege_escalation
---
# SharpUp

C# port of various [PowerUp](https://github.com/PowerShellMafia/PowerSploit/blob/dev/Privesc/PowerUp.ps1) functionality - [SharpUp](https://github.com/GhostPack/SharpUp)

## Capabilities

```bash
# Run all vulnerability checks regardless of integrity level or group membership
.\SharpUp.exe audit
```

**Checks:**

```
AlwaysInstallElevated
CachedGPPPassword
DomainGPPPassword
HijackablePaths
McAfeeSitelistFiles
ModifiableScheduledTask
ModifiableServiceBinaries
ModifiableServiceRegistryKeys
ModifiableServices
ProcessDLLHijack
RegistryAutoLogons
RegistryAutoruns
TokenPrivileges
UnattendedInstallFiles
UnquotedServicePath
```
