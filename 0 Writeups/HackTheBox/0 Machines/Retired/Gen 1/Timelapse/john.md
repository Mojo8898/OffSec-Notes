Here we can see that the password to the zip file is `supremelegacy`.
```bash
➜  timelapse john hash --wordlist=/usr/share/wordlists/rockyou.txt 
Using default input encoding: UTF-8
Loaded 1 password hash (PKZIP [32/64])
Will run 4 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
supremelegacy    (winrm_backup.zip/legacyy_dev_auth.pfx)     
1g 0:00:00:00 DONE (2022-05-22 06:34) 3.846g/s 13359Kp/s 13359Kc/s 13359KC/s surkerior..superkebab
Use the "--show" option to display all of the cracked passwords reliably
Session completed.
```
Here we can see that the password to the pfx file is `thuglegacy`.
```bash
➜  timelapse john pfx-hash --wordlist=/usr/share/wordlists/rockyou.txt 
Using default input encoding: UTF-8
Loaded 1 password hash (pfx, (.pfx, .p12) [PKCS#12 PBE (SHA1/SHA2) 256/256 AVX2 8x])
Cost 1 (iteration count) is 2000 for all loaded hashes
Cost 2 (mac-type [1:SHA1 224:SHA224 256:SHA256 384:SHA384 512:SHA512]) is 1 for all loaded hashes
Will run 4 OpenMP threads
Press 'q' or Ctrl-C to abort, almost any other key for status
thuglegacy       (legacyy_dev_auth.pfx)     
1g 0:00:00:35 DONE (2022-05-22 06:57) 0.02824g/s 91266p/s 91266c/s 91266C/s thuglife06..thsco04
Use the "--show" option to display all of the cracked passwords reliably
Session completed.
```