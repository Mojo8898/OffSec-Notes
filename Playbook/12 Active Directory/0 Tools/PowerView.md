---
tags:
  - tool
  - active_directory
---
# PowerView

Gain situational awareness in Windows Active Directory environments

```bash
cp /usr/share/windows-resources/powersploit/Recon/PowerView.ps1 .
```

## Capabilities

```powershell
# Import PowerView.ps1
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
Get-NetGroup "$GROUP" | select member
Get-NetGroup -UserName robert | select cn

# Enumerate computer objects
Get-NetComputer
Get-NetComputer | select dnshostname,operatingsystem,operatingsystemversion

# Find hosts on the local domain where the current user has local administrator access
Find-LocalAdminAccess

# Query session information
Get-NetSession -ComputerName $COMPUTER

# Enumerate SPNs linked to users
Get-NetUser -SPN | select samaccountname,serviceprincipalname

# Retrieve the ACL for the specified object
Get-ObjectAcl -Identity $OBJECT | select SecurityIdentifier,ActiveDirectoryRights
Convert-SidToName $SID
"$SID","$SID" | Convert-SidToName

# Check if any users have "GenericAll" over a specified object
Get-ObjectAcl -Identity $OBJECT | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights

# Check domain shares
Find-DomainShare
Find-DomainShare -CheckShareAccess

# Index domain share (sysvol in this example)
ls \\dc1.corp.com\sysvol\corp.com\

# Get AS-REP roastable users
Get-DomainUser -PreauthNotRequired
```

`Get-ObjectAcl -Identity stephanie` retrieves the ACL with the `ObjectID` `stephanie`. The resulting list shows `SecurityIdentifiers` that have `ActiveDirectoryRights` over `stephanie`.
