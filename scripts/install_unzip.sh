#!/bin/bash

# Exit on error
set -e

echo "Installing unzip..."

# Install unzip
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y unzip
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y unzip
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y unzip
else
    echo "Unsupported package manager. Please install unzip manually."
    exit 1
fi

echo "Unzip installation completed successfully." 