# ELF Files

## Methodology

```bash
strings filename

strace filename

ltrace filename

ghidra

gdb filename
```

### GDB

Workflow within `gdb` generally involves the following commands:

```
# Open the file with gdb
gdb encrypt

# Set a breakpoint at main
b main

# Move to the next instruction
ni

# Continue to another breakpoint
c

# Exit/quit
q
```
