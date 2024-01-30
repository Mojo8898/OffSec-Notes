# Git Enumeration

- [GitTools](https://github.com/internetwache/GitTools) and use ``
	- Allows us to dump remote `.git` repository
- `git status` with `.git` folder inside current folder
	- Shows files missing from the current folder based on the dumped `.git` directory
- `git checkout -- .`
	- Reverts current folder to previous commit to restore the repository solely based on the dumped `.git` directory
