---
tags:
  - tool
---
# swaks

All things SMTP

## Capabilities

```bash
# Get help menu
swaks --help

# Send an email
swaks -t target@$DOMAIN -f user@example.com -h 'Subject: example_subject' --body 'example_body'
swaks -t target@$DOMAIN -f user@example.com -h 'Subject: example_subject' --body 'example_body' -s $IP
swaks -t target@$DOMAIN -f user@example.com -h 'Subject: example_subject' --body 'example_body' -s $IP --suppress-data

# Send an email with an attachment
swaks -t target@$DOMAIN --attach @example.txt -f user@example.com -h 'Subject: example_subject' --body 'example_body' -s $IP

# Add authentication
swaks -t target@$DOMAIN -f user@example.com --auth-user user@example.com -auth-password 'password' -h 'Subject: example_subject' --body 'example_body' -s $IP
```
