#!/bin/bash

# Exit on error
set -e

echo "Installing LZ4 compression tools..."

# Install LZ4 tools
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y liblz4-tool
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y lz4
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y lz4
else
    echo "Unsupported package manager. Please install LZ4 tools manually."
    exit 1
fi

echo "LZ4 compression tools installation completed successfully."
echo "Usage examples:"
echo "  - Compress:   lz4 file.txt file.txt.lz4"
echo "  - Decompress: lz4 -d file.txt.lz4 file.txt"
echo "  - Compress with maximum compression: lz4 -9 file.txt file.txt.lz4" 