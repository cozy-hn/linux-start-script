#!/bin/bash

# Exit on error
set -e

echo "Installing iotop (I/O monitoring tool)..."

# Install iotop
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y iotop
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y iotop
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y iotop
else
    echo "Unsupported package manager. Please install iotop manually."
    exit 1
fi

echo "Iotop installation completed successfully."
echo "Run 'iotop' to monitor disk I/O usage (requires root privileges)."
echo "Example: sudo iotop -o (shows only processes that are actively doing I/O)" 