# Methodology

### Enumeration

```bash
# Download a .git directory from a website
git-dumper http://example.com/.git/ example.com

# Scan for secrets in the git repository in the current directory
gitleaks detect -v

# Scan uncommitted changes
gitleaks protect -v
gitleaks protect --staged -v

# Check repo status
git status

# Display branches
git branch

# Change branches
git switch <branch>

# Show commits within the current branch
git log

# Show changes related to a specified commit
git show <commit_id>
```
