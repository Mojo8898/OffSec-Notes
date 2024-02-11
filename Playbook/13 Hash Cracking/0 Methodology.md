# Methodology

```bash
# Check type
hashid -m $HASH

# Attempt to crack with hashcat
hashcat -m 0 $HASH /usr/share/wordlists/rockyou.txt --force

# Try using john if hashcat has issues
john --wordlist=/usr/share/wordlists/rockyou.txt $HASH

# Attempt to crack with CrackStation
https://crackstation.net/
```
