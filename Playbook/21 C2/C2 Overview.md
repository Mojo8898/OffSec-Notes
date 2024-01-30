## C2 Overview

### Tools

- [Sliver](Tools/Sliver/Sliver.md)

### Links

- [Infection chain](https://encyclopedia.kaspersky.com/glossary/infection-chain/#:~:text=Infection%20chain%20is%20the%20infosec,installing%20and%20running%20a%20payload.)
- [Payload analysis](https://www.microsoft.com/security/blog/2016/07/14/reverse-engineering-dubnium-stage-2-payload-analysis/)
- [Unit 42 BRC4](https://unit42.paloaltonetworks.com/brute-ratel-c4-tool/)
- [DLL Proxying](https://itm4n.github.io/dll-proxying/)

### Social Engineering Vectors
- Malicious shortcut to DLL hijacking
- Malicious Word/Excel macros

### Note - Find executables susceptible to DLL hijacking on twitter by searching `#lolbin` (living off the land binary)

### Host Data Exfiltration Armory Modules

- `c2tc-askcreds` - Collect passwords using `CredUIPromptForWindowsCredentialsName`
- `c2tc-psw` - Show Window titles from processes with active Windows
- `c2tc-smbinfo` - Gather remote system version info using the `NetWkstaGetInfo` API
- `c2tc-winver` - Display the version of Windows that is running, the build number and patch release (Update Build Revision)
- `chromiumkeydump` - Dump Chrome/Edge Masterkey
- `credman` - Dump credentials using the `CredsBackupCredentials` API
- `handlekatz` - Implementation of `handlekatz` as a BOF (x64 only)

### Potential Objectives

- Passwords

