---
tags:
  - tool
  - git
  - osint
---
# trufflehog

Find leaked credentials

## Capabilities

```bash
# Scan a github repo for only verified secrets
trufflehog git https://github.com/trufflesecurity/test_keys --only-verified

# Scan a github repo + its issues and pull requests
trufflehog github --repo https://github.com/trufflesecurity/test_keys --issue-comments --pr-comments
```
