## find
Find files on a linux machine
### Key Flags
- `-type <type>` Specify `d` for directory and `f` for file among others
- `-name <name>`
- `-user <user>`
- `-group <group>`
- `-size <size>`
	- Prefixes
		- `+` Greater than
		- `-` Less than
	- Suffixes
		- `c` Bytes
		- `k` Kilobytes
		- `M` Megabytes
		- `G` Gigabytes
- `-newermt <date>` Format: `<year>-<month>-<day>`
- `-exec <command>` Typically followed by `ls -al {} \; 2>/dev/null`
### Examples
`find / -type f -group <current group> -exec ls -al {} \; 2>/dev/null`
- Finds files that share the same group as you (find your group with the command: `groups`)

`find / -type f -name *.conf -user root -size +20k -newermt 2020-03-03 -exec ls -al {} \; 2>/dev/null`
- Finds files ending in `.conf`, owned by `root`, with a size larger than 20k, and modified earlier than 2020-03-03
---
[Home](Tool%20Index.md)