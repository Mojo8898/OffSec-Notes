# Methodology

## Enumeration

```bash
# Start with a banner grab
nc -vn $IP 25

# Check for open relay
nmap -p 25 --script smtp-open-relay $IP -v

# Send an email with our IP to see if they click on it
swaks -t target@$DOMAIN --from user@example.com --header 'Subject: example_subject' --body 'http://OUR_IP' --server $IP --suppress-data

# Manually enumerate
telnet $IP 25
```

## Commands

See [HackTricks](https://book.hacktricks.xyz/network-services-pentesting/pentesting-smtp/smtp-commands)
