#!/bin/bash

# Exit on error
set -e

echo "Installing aria2 download manager..."

# Install aria2
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y aria2
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y aria2
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y aria2
else
    echo "Unsupported package manager. Please install aria2 manually."
    exit 1
fi

echo "Aria2 installation completed successfully."
echo "Usage example: aria2c https://example.com/file.zip" 