#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

echo "Optimizing system for high RAM (128GB)..."

# Backup current sysctl configuration
cp /etc/sysctl.conf /etc/sysctl.conf.backup.$(date +%Y%m%d%H%M%S)

# Get total memory in KB
TOTAL_MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
echo "Total memory detected: $((TOTAL_MEM/1024/1024)) GB"

# Create RAM optimization settings
cat >> /etc/sysctl.conf << EOF

# RAM optimization for high-memory server

# File system cache tuning
vm.vfs_cache_pressure = 50
vm.dirty_background_ratio = 5
vm.dirty_ratio = 10

# Virtual memory settings
vm.min_free_kbytes = $((TOTAL_MEM / 100))

# Set swappiness to minimum (we have plenty of RAM)
vm.swappiness = 1
EOF

# Increase file limits
cat > /etc/security/limits.d/90-nproc.conf << EOF
# Increase open file limits for all users
*         soft    nofile          1048576
*         hard    nofile          1048576
root      soft    nofile          1048576
root      hard    nofile          1048576
EOF

# Apply changes
sysctl -p

# Setup tmpfs for frequently accessed directories
# mkdir -p /var/tmp/tmpfs

# cat >> /etc/fstab << EOF
# # RAM-based tmpfs for frequently accessed directories
# tmpfs   /tmp         tmpfs   nosuid,size=8G   0  0
# tmpfs   /var/tmp/tmpfs     tmpfs   nosuid,size=16G  0  0
# EOF

# # Remount the file systems
# mount -a || echo "Warning: mount failed, changes will apply after reboot"

echo "RAM optimization complete. Changes will persist after reboot."
echo "System tuned for optimal performance with high memory (128GB)." 