PS C:\Users\zmews\clones\hashcat> hashcat -m 7300 -o .\output\ipmi-output.txt .\hashlists\ipmi-dumphashes.txt .\wordlists\rockyou.txt
hashcat (v6.2.5) starting

* Device #1: WARNING! Kernel exec timeout is not disabled.
             This may cause "CL_OUT_OF_RESOURCES" or related errors.
             To disable the timeout, see: https://hashcat.net/q/timeoutpatch
* Device #2: WARNING! Kernel exec timeout is not disabled.
             This may cause "CL_OUT_OF_RESOURCES" or related errors.
             To disable the timeout, see: https://hashcat.net/q/timeoutpatch
CUDA API (CUDA 11.6)
====================
* Device #1: NVIDIA GeForce GTX 1070 Ti, 7217/8191 MB, 19MCU

OpenCL API (OpenCL 3.0 CUDA 11.6.110) - Platform #1 [NVIDIA Corporation]
========================================================================
* Device #2: NVIDIA GeForce GTX 1070 Ti, skipped

Minimum password length supported by kernel: 0
Maximum password length supported by kernel: 256

Hashes: 1 digests; 1 unique digests, 1 unique salts
Bitmaps: 16 bits, 65536 entries, 0x0000ffff mask, 262144 bytes, 5/13 rotates
Rules: 1

Optimizers applied:
* Zero-Byte
* Not-Iterated
* Single-Hash
* Single-Salt

ATTENTION! Pure (unoptimized) backend kernels selected.
Pure kernels can crack longer passwords, but drastically reduce performance.
If you want to switch to optimized kernels, append -O to your commandline.
See the above message to find out about the exact limits.

Watchdog: Temperature abort trigger set to 90c

Host memory required for this attack: 333 MB

Dictionary cache hit:
* Filename..: .\wordlists\rockyou.txt
* Passwords.: 14344385
* Bytes.....: 139921507
* Keyspace..: 14344385


Session..........: hashcat
Status...........: Cracked
Hash.Mode........: 7300 (IPMI2 RAKP HMAC-SHA1)
Hash.Target......: 32bac01c021200004a7d018db2becccb43801dba580b666d8a1...cf67a9
Time.Started.....: Mon Mar 07 19:28:31 2022 (0 secs)
Time.Estimated...: Mon Mar 07 19:28:31 2022 (0 secs)
Kernel.Feature...: Pure Kernel
Guess.Base.......: File (.\wordlists\rockyou.txt)
Guess.Queue......: 1/1 (100.00%)
Speed.#1.........: 11784.0 kH/s (9.93ms) @ Accel:1024 Loops:1 Thr:64 Vec:1
Recovered........: 1/1 (100.00%) Digests
Progress.........: 7471104/14344385 (52.08%)
Rejected.........: 0/7471104 (0.00%)
Restore.Point....: 6225920/14344385 (43.40%)
Restore.Sub.#1...: Salt:0 Amplifier:0-1 Iteration:0-1
Candidate.Engine.: Device Generator
Candidates.#1....: lidiaolinda -> iarn17
Hardware.Mon.#1..: Temp: 54c Fan: 15% Util: 20% Core:1618MHz Mem:4006MHz Bus:16

Started: Mon Mar 07 19:28:18 2022
Stopped: Mon Mar 07 19:28:32 2022

Outfile: 32bac01c021200004a7d018db2becccb43801dba580b666d8a14d7417c90c3ff3ecb55b59cd41662a123456789abcdefa123456789abcdef140d41646d696e6973747261746f72:e5f740c255dfa1d5f5ed48fc2da26252f8cf67a9:**ilovepumkinpie1**

7621da3f024edc8d2c615f64b5eb7064