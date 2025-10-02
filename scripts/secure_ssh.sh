#!/bin/bash

echo "Disabling SSH password authentication..."

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

# Backup the original SSH config
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup.$(date +%Y%m%d%H%M%S)

# Disable password authentication
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config

# Ensure public key authentication is enabled
sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Restart SSH service
if [ -f /bin/systemctl ] || [ -f /usr/bin/systemctl ]; then
    # Try sshd first, then ssh
    if systemctl is-active --quiet sshd 2>/dev/null; then
        systemctl restart sshd
    elif systemctl is-active --quiet ssh 2>/dev/null; then
        systemctl restart ssh
    else
        echo "Could not find sshd or ssh service. Please restart SSH manually."
    fi
elif [ -f /etc/init.d/sshd ]; then
    /etc/init.d/sshd restart
elif [ -f /etc/init.d/ssh ]; then
    /etc/init.d/ssh restart
else
    echo "Could not restart SSH service. Please restart it manually."
fi

echo "SSH has been configured to disable password authentication."
echo "WARNING: Make sure you have already added your SSH key to the server before disconnecting!"
echo "If you haven't added your key yet, you may be locked out of your server." 