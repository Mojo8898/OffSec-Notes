---
tags:
  - tool
  - git
  - osint
---
# gitleaks

Detect secrets in github repositories

## Capabilities

```bash
# Scan for secrets in the git repository in the current directory
gitleaks detect -v

# Save the report in a file called gitleaks-report.json (useful for large repositories)
gitleaks detect --report-path gitleaks-report.json
# Use the previous report as a baseline to continue where it left off
gitleaks detect --baseline-path gitleaks-report.json --report-path findings.json

# Scan uncommitted changes
gitleaks protect -v
gitleaks protect --staged -v
```
