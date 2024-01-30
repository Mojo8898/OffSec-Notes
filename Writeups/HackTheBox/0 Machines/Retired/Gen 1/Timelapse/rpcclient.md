Although I was able to authenticate as null, I did not have any permissions.
```bash
➜  timelapse rpcclient 10.10.11.152
Password for [WORKGROUP\kali]:
Bad SMB2 (sign_algo_id=1) signature for message
[0000] 00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00   ........ ........
[0000] 84 9C 71 21 A0 E6 1A 25   DE 1C 4B 6B A7 51 8E 70   ..q!...% ..Kk.Q.p
Cannot connect to server.  Error was NT_STATUS_ACCESS_DENIED
➜  timelapse rpcclient 10.10.11.152 -U ''
Password for [WORKGROUP\]:
rpcclient $> enumdomusers
result was NT_STATUS_ACCESS_DENIED
```