## Enumeration
### Nmap
Lets start by scanning the machine with `Nmap`.
```bash
sudo nmap -sC -sV -T4 -p- --min-rate=1000 10.129.49.99
```
![](screenshots/Pasted%20image%2020220826214358.png)
The output of `Nmap` shows that the machine is a Windows Active Directory server with the hostname `dc` and the domain `support.htb` so we can go ahead and add both of those to our `/etc/hosts` file. We also notice that SMB is open so we can go ahead and enumerate it.
### SMB
We can first test anonymous authentication with `CrackMapExec` using the following command.
```bash
crackmapexec smb 10.129.49.99 -u Guest -p '' --shares
```
![](screenshots/Pasted%20image%2020220826214146.png)
We can then view the share `support-tools` with `smbclient`.
```bash
smbclient -N //10.129.49.99/support-tools
```
![](screenshots/Pasted%20image%2020220826214654.png)
We find many files on the share, but the only one of interest is `UserInfo.exe.zip` as the rest are open source tools, so we can download `UserInfo.exe.zip`.
```bash
get UserInfo.exe.zip
```
![](screenshots/Pasted%20image%2020220826214908.png)
Upon unzipping the folder, we find the file `UserInfo.exe`.
![](screenshots/Pasted%20image%2020220826215817.png)
We can see the file is of type `Mono/.Net assembly` so we can proceed by reverse engineering it in `dnSpy`.
### dnSpy
In dnSpy, we find the class `LdapQuery`
![](screenshots/Pasted%20image%2020220826220619.png)
This class calls the method `Protected.getPassword()` and passes it into the `DirectoryEntry(...)` method. Lets view the `Protected` class to see the `getPassword()` method.
![](screenshots/Pasted%20image%2020220826221111.png)
We can see the method simply passes in an encrypted password (`enc_password`) and decrypts it with a function. Lets run this function in VSCode to find the password passed into `DirectoryEntry(...)`.
![](screenshots/Pasted%20image%2020220826221650.png)
We can then add a main method and prepend `(byte)` to the text highlighted in red as the evaluation needs to be casted in our case.
![](screenshots/Pasted%20image%2020220826222023.png)
Now we can run the program to view our encrypted password!
![](screenshots/Pasted%20image%2020220826222119.png)

---
[foothold](foothold.md)