# Methodology

## Enumerate

```bash
# Start with a banner grab
nc -vn $IP 25

# Check for open relay
nmap -p 25 --script smtp-open-relay $IP -v

# Send an email with our IP to see if they click on it
swaks -t target@$DOMAIN -f user@example.com -h 'Subject: example_subject' --body 'http://OUR_IP' -s $IP --suppress-data

# Send a malicious phishing email

```

## Connect

```bash
telnet $IP 25
```

### Session Commands

See [HackTricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-smtp/smtp-commands)
