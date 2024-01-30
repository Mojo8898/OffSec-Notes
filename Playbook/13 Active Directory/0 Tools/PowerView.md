---
tags:
---
# PowerView

Gain situational awareness in Windows Active Directory environments

## Capabilities

```powershell
# Import PowerView.ps1
Import-Module .\PowerView.ps1
. .\PowerView.ps1

# Enumerate domain information (check Pdc)
Get-NetDomain

# Enumerate user objects
Get-NetUser
Get-NetUser | select cn
Get-NetUser | select cn,pwdlastset,lastlogon

# Enumerate group objects
Get-NetGroup
Get-NetGroup | select cn
Get-NetGroup "Sales Department" | select member
Get-NetGroup -UserName robert | select cn

# Enumerate computer objects
Get-NetComputer
Get-NetComputer | select dnshostname,operatingsystem,operatingsystemversion

# Find hosts on the local domain where the current user has local administrator access
Find-LocalAdminAccess

# Query session information
Get-NetSession -ComputerName client74

# Enumerate SPNs for all users
Get-NetUser -SPN | select samaccountname,serviceprincipalname

# Retrieve the ACL for the specified object
Get-ObjectAcl -Identity stephanie
Get-ObjectAcl -Identity "Management Department" | select SecurityIdentifier,ActiveDirectoryRights

# Check if any users have "GenericAll" over "Management Department"
Get-ObjectAcl -Identity "Management Department" | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights

# Add and remove "setphanie" from "Management Department"
net group "Management Department" stephanie /add /domain
net group "Management Department" stephanie /del /domain

# Convert SID to object name
Convert-SidToName S-1-5-21-3633066894-3045594602-554748096-500
"S-1-5-21-1987370270-658905905-1781884369-512","S-1-5-21-1987370270-658905905-1781884369-1104","S-1-5-32-548","S-1-5-18","S-1-5-21-1987370270-658905905-1781884369-519" | Convert-SidToName

# Find domain shares
Find-DomainShare
Find-DomainShare -CheckShareAccess

# Index domain share (sysvol in this example)
ls \\dc1.corp.com\sysvol\corp.com\

# Get AS-REP roastable users
Get-DomainUser -PreauthNotRequired
```

`Get-ObjectAcl -Identity stephanie` retrieves the ACL with the `ObjectID` `stephanie`. The resulting list shows `SecurityIdentifiers` that have `ActiveDirectoryRights` over `stephanie`.
