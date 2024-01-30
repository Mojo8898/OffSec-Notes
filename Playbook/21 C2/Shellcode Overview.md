## Execute Windows Shellcode
### Virtual memory space reserved for user processes (user space) and virtual memory space reserved for system processes (kernel space)
![](../../0%20Attachments/Pasted%20image%2020220901211506.png)
**The first takeaway from this is that each process gets its own, private virtual address space, where the “kernel space” is kind of a “shared environment”**
Meaning that each kernel process can read/write to virtual memory anywhere it wants to (unless virtualization-based security (VBS) exists in the environment).
### Single Process
![](../../0%20Attachments/Pasted%20image%2020220901211833.png)
ASLR - Address Space Layout Randomization
DEP - Data Execution Prevention

### Block Meanings
- **.TEXT Segment** - This is where the executable process image is placed. In this area you will find the main entry of the executable, where the execution flow starts.
- **.DATA Segment** - The .DATA section contains globally initialized or static variables. Any variable that is not bound to a specific function is stored here.
- .**BSS Segment** - Similar to the .DATA segment, this section holds any uninitialized global or static variables.
- **HEAP** - This is where all your dynamic local variables are stored. Every time you create an object for which the space that is needed is determined at run time, the required address space is dynamically assigned within the HEAP (usually using alloc() or similar system calls).
- **STACK** - The stack is the place every static local variable is assigned to. If you initialize a variable locally within a function, this variable will be placed on the STACK.
