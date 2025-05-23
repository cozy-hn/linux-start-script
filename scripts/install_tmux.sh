#!/bin/bash

# Exit on error
set -e

echo "Installing tmux..."

# Install tmux
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y tmux
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y tmux
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y tmux
else
    echo "Unsupported package manager. Please install tmux manually."
    exit 1
fi
# To start a new tmux session, run: tmux new -s session_name
# To attach to an existing session, run: tmux attach -t session_name
# To list all sessions, run: tmux ls
# To detach from a session, press: Ctrl+b then d

echo "Tmux installation completed successfully."
echo "Run 'tmux' to start using it." 