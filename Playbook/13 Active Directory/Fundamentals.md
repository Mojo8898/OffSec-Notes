# Fundamentals

### Distinguished Name (DN)

A string that uniquely identifies an object in AD ([DN Attributes](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/ldap/distinguished-names)), think of it as a hierarchy

DN attributes:

- `DC` Domain Component - A component label of a DNS domain name
- `CN` Common Name - Naming attribute for objects of class user, contact, computer, group, and container (ex. `cn=Jim Smith,ou=West,dc=mydomain,dc=com`)
- `OU` Organization Unit - Containers for objects within the domain (ex. `ou=West,dc=mydomain,dc=com`)

- `basedn` Base Distinguished Name (`searchbase`) - Where the PAN will start searching in the directory structure
- `binddn` Bind Distinguished Name - The username that will be used to do the searching and request the authentication

AD Object - Entities that represent a resource such as users, computers, or printers

### Service Principle Name (SPN)

When applications like *Exchange*, MS SQL, or IIS are integrated into AD, a unique service instance identifier known as a *Service Principal Name* (SPN) associates a service to a specific service account in Active Directory.

### Object Permissions

In short, an object in AD may have a set of permissions applied to it with multiple *Access Control Entries* (ACE). These ACEs make up the *Access Control List* (ACL).

- `GenericAll` - Full permissions on object
- `GenericWrite` - Edit certain attributes on the object
- `WriteOwner` - Change ownership of the object
- `WriteDACL` - Edit ACE's applied to object
- `AllExtendedRights` - Change password, reset password, etc.
- `ForceChangePassword` - Password change for object
- `Self (Self-Membership)` - Add ourselves to for example a group

ACE entries contain an `ObjectSID` attribute which is a SID that identifies the object itself, while the `SecurityIdentifier` attribute is a SID that specifies which security principal has the permissions defined in the ACE.

### Domain Shares

Default domain shares are hidden, indicated by the `$` at the end of their names.

- `SYSVOL` - Typically used for various domain policies and scripts.
	- Mapped to `%SystemRoot%\SYSVOL\Sysvol\domain-name` by default.

```powershell
ls \\dc1.corp.com\sysvol\corp.com\
```

- `ADMIN$` - Used for remote administration. Points to `%SystemRoot%` (usually `C:\Windows`).
- `C$`, `D$`, `E$`, etc. - Represents default drive shares. Each allow administrators to access the entire drive remotely.
- `NETLOGON` - Used for logon scripts and Group Policy. Located in the `NETLOGON` folder of the domain controller's `Sysvol` directory.
- `IPC$` - Used for inter-process communication. It doesn't correspond to a physical directory.
- `PRINT$` - Used for shared printers.

