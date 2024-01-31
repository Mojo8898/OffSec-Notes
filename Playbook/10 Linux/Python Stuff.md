# Python Stuff

## Virtual Environments

Stop clobbering your system with python installations

### Option 1: pipx (recommended if possible)

```bash
# Install the github repository with pipx to keep it containerized
pipx install git+https://github.com/Tib3rius/AutoRecon.git

# Use the following example to run the tool with sudo
sudo $(which autorecon) [OPTIONS]
```

### Option 2: venv

```bash
# Enter the python repository
cd /opt/pypykatz

# Create the virtual environment
python3 -m venv venv

# Enter the virtual environment
source venv/bin/activate

# Install the package
python3 setup.py install
```

**Note:** Use `ipython3` for debugging/executing blocks on the fly
