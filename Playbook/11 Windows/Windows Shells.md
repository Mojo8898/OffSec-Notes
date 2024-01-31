# Windows Shells

All things Windows shells

## Fundamentals

We can use [revshells](https://www.revshells.com/). We will default to using `PowerShell #2`, but fall back on  `PowerShell #3` if we encounter issues. Note, `PowerShell #3 (Base64)` actually uses `PowerShell #2`.

We can also utilize `rlwrap` with a couple options to durastically increase the stability and ease of use of our netcat shell.

```bash
rlwrap -crA nc -lvnp 9001
```

**Utility options:**

- `-nop` (no profile) prevents PowerShell from loading the user's profile script when the session starts in order to ensure that the PowerShell session starts with a default, predictable environment.
- `-w hidden` (window hidden) makes it so the PowerShell window is not shown to the user
- `-noni` (non-interactive) prevents the shell from inadvertently pausing during execution. This option is not necessary but useful just incase
- `-ep bypass` (execution policy bypass) is also not necessary as `IEX` can execute scripts regardless of execution policy, but should be added in case to ensure execution regardless of the environment.

**Execution options:**

- `-c` will execute the following PowerShell command script or block in quotes
- `-e` will execute base64 encoded `UTF-16LE` PowerShell command script or block

Use the following command to properly convert shellcode to `UTF-16LE` format before base64 encoding it

```bash
cat shell | iconv -t utf-16le | base64 -w 0
```

**Note:** Powercat has the advantage of providing an interactive shell to run interactive programs such as winPEAS or mimikatz
