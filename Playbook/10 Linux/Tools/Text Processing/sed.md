---
tags:
  - text_processing
---
# sed

Stream edit

## Capabilities

```bash
# Delete all lines starting with 1
sed -i '/^1/d' filename

# Replace instances of "; " with ";\n"
sed -i 's/; /;\n/g' filename

# Prepend text to all lines in a file
sed -i 's/^/PREFIX/' file.txt
```
