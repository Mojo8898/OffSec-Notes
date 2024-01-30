# Bash Inline

## Commands

### Check for dangerous functions

In this case we are checking for the `system()` function in perl files

```bash
for i in $(ls /usr/bin/zm*.pl); do echo $i; grep "system(" $i; done
```
