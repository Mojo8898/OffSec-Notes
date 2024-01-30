---
tags:
  - text_processing
---
# tr

Translate or delete individual characters

## Capabilities

```bash
# Convert lowercase to uppercase
echo "hello world" | tr "a-z" "A-Z"

# Delete characters
echo "hello 123 world 456" | tr -d '0-9'

# Replace spaces with newlines
echo "hello world" | tr ' ' '\n'

# Squeeze repeated characters
echo "hello     world" | tr -s ' '
```
