---
tags:
  - reverse_engineering
---
# gdb

GNU debugger

## Capabilities

### Stepping

Increment instructions

```
# Execute next instruction
si

# Execute next instruction, but execute function calls as one instruction (staying in the current stack frame)
ni

# Return to the calling function
fin
```

### Examine

Examine memory address

```bash
x/a $rbp + 8
```

In this example, we are checking the return address of the current function to determine if it has been overwritten during a segmentation fault

Note: `a` stands for address, other options available include:

- `x/s` to display a string
- `x/c` to display characters

### Breakpoints

In the following example, we are segmentation faulting on the address `validating_userinput+270`

```
[!] Unmapped address: '0x800000002300'
──────────────────────────────────────────────────────────────────────────────────────────────────── code:x86:64 ────
   0x7ffff7fb894c <validating_userinput+252> lea    r12, [rbp-0x670]
   0x7ffff7fb8953 <validating_userinput+259> and    rdi, 0xfffffffffffffff8
   0x7ffff7fb8957 <validating_userinput+263> lea    r14, [rbp-0x600]
 → 0x7ffff7fb895e <validating_userinput+270> mov    QWORD PTR [r13+0x0], rdx
   0x7ffff7fb8962 <validating_userinput+274> sub    rcx, rdi
   0x7ffff7fb8965 <validating_userinput+277> mov    rdx, QWORD PTR [rbp-0x28]
   0x7ffff7fb8969 <validating_userinput+281> sub    rax, rcx
   0x7ffff7fb896c <validating_userinput+284> add    ecx, 0x320
   0x7ffff7fb8972 <validating_userinput+290> mov    QWORD PTR [r13+0x318], rdx
```

To set a breakpoint and inspect the stack frame before the segmentation fault, we would use the command:

```
b *(validating_userinput+263)
```

We can then see the breakpoint with the command:

```
info b
```

And delete it with the command:

```
del br <num>
```

Note: We can always go back to the primary view we see when first segmentation faulting with the command:

```
context
```

### Disassembly

We can view the dissasembly for a function with the following command

```
disas event_recorder
```

Where `event_recorder` is the function we are disassembling

We can use this disassembly view to view specific functions and set breakpoints within them

This is especially helpful to view where data goes during execution

### Visualize Stack

We can adjust our offset and visualize the stack at any point with the following example

GDB stack view (in context)

```
0x00007fffffffa268│+0x0000: 0x00007ffff7fb89a1  →  <validating_userinput+337> mov rsi, rbx       ← $rsp
0x00007fffffffa270│+0x0008: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX//[...]"    ← $r13                       
0x00007fffffffa278│+0x0010: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX//////////[...]"                                 
0x00007fffffffa280│+0x0018: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX//////////////////[...]"                                 
0x00007fffffffa288│+0x0020: "XXXXXXXXXXXXXXXXXXXXXXXX//////////////////////////[...]"                                 
0x00007fffffffa290│+0x0028: "XXXXXXXXXXXXXXXX//////////////////////////////////[...]"                                 
0x00007fffffffa298│+0x0030: "XXXXXXXX//////////////////////////////////////////[...]"                                 
0x00007fffffffa2a0│+0x0038: "//////////////////////////////////////////////////[...]"
```

View 100 addresses starting with `0x00007fffffffa270` (the first address after the stack pointer)

```
x/100a 0x00007fffffffa270
```

### Security Controls

Check security controls by running

```
checksec
```

## Tricks

### Finding Addresses in Ghidra

View a corresponding GDB address in ghidra by looking at the last 3 characters for the address.

In the following example, the program is crashing at memory address `95e`

```
[!] Unmapped address: '0x800000002300'
──────────────────────────────────────────────────────────────────────────────────────────────────── code:x86:64 ────
   0x7ffff7fb894c <validating_userinput+252> lea    r12, [rbp-0x670]
   0x7ffff7fb8953 <validating_userinput+259> and    rdi, 0xfffffffffffffff8
   0x7ffff7fb8957 <validating_userinput+263> lea    r14, [rbp-0x600]
 → 0x7ffff7fb895e <validating_userinput+270> mov    QWORD PTR [r13+0x0], rdx
   0x7ffff7fb8962 <validating_userinput+274> sub    rcx, rdi
   0x7ffff7fb8965 <validating_userinput+277> mov    rdx, QWORD PTR [rbp-0x28]
   0x7ffff7fb8969 <validating_userinput+281> sub    rax, rcx
   0x7ffff7fb896c <validating_userinput+284> add    ecx, 0x320
   0x7ffff7fb8972 <validating_userinput+290> mov    QWORD PTR [r13+0x318], rdx
```

This can be located in ghidra by jumping to the `validating_userinput` function and going to the memory address ending in `95e`

### Info

The following are some commonly used info commands:

```
# breakpoints
info b

# current stack frame arguments
info args

# stack frame
info f

# call stack (backtrace)
bt

# functions
info func

# variables
info var

# registers
info reg

# shared libraries
info shared

# proc mappings
info proc mappings

# symbols
info symbol <symbol>

# files
info file

# address of code for the given line
info line <line>

# local variables
info locals
```