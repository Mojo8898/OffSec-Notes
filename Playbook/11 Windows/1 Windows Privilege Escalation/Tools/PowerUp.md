---
tags:
  - tool
  - windows
  - privilege_escalation
---
# PowerUp

Clearinghouse of common Windows privilege escalation vectors that rely on misconfigurations - [PowerUp](https://github.com/PowerShellMafia/PowerSploit/blob/master/Privesc)

## Methodology

Start by copying `PowerUp.ps1` to the current directory

```bash
cp /usr/share/windows-resources/powersploit/Privesc/PowerUp.ps1 .
```

Bypass execution if not already bypassed, and dot source the file

```powershell
# Check execution policy with: Get-ExecutionPolicy
powershell -ep bypass
. .\PowerUp.ps1
```

### Capabilities

```powershell
# Enable privilege
Enable-Privilege

# Check for unquoted service path
Get-UnquotedService

# Check for binary hijacking
Get-ModifiableServiceFile
Get-ModifiableService

# Check for DLL hijacking
Find-PathDLLHijack

# Check registry
Get-RegistryAlwaysInstallElevated
Get-RegistryAutoLogon
Get-ModifiableRegistryAutoRun

# Misc checks
Get-ModifiableScheduledTaskFile
Get-UnattendedInstallFile
Get-Webconfig
Get-ApplicationHost
Get-SiteListPassword
Get-CachedGPPPassword
```
