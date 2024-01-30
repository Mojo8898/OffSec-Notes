---
tags:
---
# BloodHound

Reveal hidden relationships within AD

SharpHound - Official data collector for BloodHound, performs all enumeration automatically and outputs to .json files ([documentation](https://bloodhound.readthedocs.io/en/latest/data-collection/sharphound.html))

## Setup

### SharpHound

We first need to collect data from our target with [SharpHound](https://github.com/BloodHoundAD/SharpHound)

```bash
# Grab local collectors in kali
cp /usr/lib/bloodhound/resources/app/Collectors/SharpHound.ps1 .
cp /usr/lib/bloodhound/resources/app/Collectors/SharpHound.exe .
```

```bash
# Import Sharphound.ps1
Import-Module .\SharpHound.ps1

# Check help menu
Get-Help Invoke-BloodHound

# Execute Bloodhound
Invoke-BloodHound -CollectionMethod All -OutputDirectory C:\Users\stephanie\Desktop\ -OutputPrefix "stephanie_client75"
Invoke-BloodHound -CollectionMethod All -OutputDirectory C:\Temp\ -OutputPrefix "alaading"
```

### BloodHound

We can now run BloodHound

```bash
# Clear the database before starting a new session
sudo rm -r /etc/neo4j/data

# Start neo4j (creds - neo4j:neo4j)
sudo neo4j start
```

Connect via `http` at `http://localhost:7474` and change the default password

```bash
# Start bloodhound
bloodhound
```

We can now use the `Upload Data` function on the right side of the GUI to upload the zip file, or drag-and-drop it into BloodHound's main window.

See [here](https://support.websoft9.com/en/docs/neo4j) if you forgot your password (I set mine to `Password123`)

## Analysis

- Start by marking owned targets
- We can now get a high level overview of the environment

`Find Shortest Paths to Domain Admins` (at the bottom of analysis tab)
