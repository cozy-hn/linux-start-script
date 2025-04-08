#!/bin/bash

# I have plenty of memory, so I need to lower it

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Get current swappiness value
CURRENT_SWAPPINESS=$(cat /proc/sys/vm/swappiness)
echo "Current swappiness value: $CURRENT_SWAPPINESS"

# Set new swappiness value (default to 10 if not provided)
NEW_SWAPPINESS=${1:-10}

# Set swappiness for current session
echo $NEW_SWAPPINESS > /proc/sys/vm/swappiness
echo "Swappiness set to $NEW_SWAPPINESS for current session"

# Make the change permanent
if grep -q "vm.swappiness" /etc/sysctl.conf; then
    # Update existing setting
    sed -i "s/vm.swappiness=.*/vm.swappiness=$NEW_SWAPPINESS/" /etc/sysctl.conf
else
    # Add new setting
    echo "vm.swappiness=$NEW_SWAPPINESS" >> /etc/sysctl.conf
fi

echo "Swappiness permanently set to $NEW_SWAPPINESS"
echo "System will now use memory more aggressively and swap less frequently"