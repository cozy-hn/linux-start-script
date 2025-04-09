#!/bin/bash

# Exit on error
set -e

echo "Installing jq (JSON processor)..."

# Install jq
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    apt-get update
    apt-get install -y jq
elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    yum install -y jq
elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    dnf install -y jq
else
    echo "Unsupported package manager. Please install jq manually."
    exit 1
fi

echo "jq installation completed successfully."
echo "Usage examples:"
echo "  - Parse JSON file: jq '.' file.json"
echo "  - Extract specific field: jq '.field' file.json"
echo "  - Filter array: jq '.items[] | select(.name==\"example\")' file.json" 