#!/bin/bash

# Exit on error
set -e

echo "Installing Ookla Speedtest CLI..."

# Check if we're root
if [ $(id -u) -ne 0 ]; then
    echo "This script must be run as root or with sudo privileges."
    exit 1
fi

# Detect package manager
if command -v apt-get >/dev/null 2>&1; then
    # For Debian/Ubuntu based systems
    echo "Detected Debian/Ubuntu based system."
    
    # Add Ookla repository
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | bash
    
    # Install speedtest
    apt-get install -y speedtest
    
elif command -v yum >/dev/null 2>&1; then
    # For CentOS/RHEL systems
    echo "Detected CentOS/RHEL based system."
    
    # Add Ookla repository
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | bash
    
    # Install speedtest
    yum install -y speedtest
    
elif command -v dnf >/dev/null 2>&1; then
    # For Fedora systems
    echo "Detected Fedora based system."
    
    # Add Ookla repository
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | bash
    
    # Install speedtest
    dnf install -y speedtest
    
else
    echo "Unsupported package manager. Please install Speedtest CLI manually."
    exit 1
fi

echo "Ookla Speedtest CLI installation completed successfully."
echo "Run 'speedtest' to test your internet connection." 