#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

echo "Optimizing NVMe SSD performance..."

# Get NVMe device name
NVME_DEVICES=$(lsblk -d -o name,model | grep -i nvme | awk '{print $1}')

if [ -z "$NVME_DEVICES" ]; then
  echo "No NVMe devices found."
  exit 1
fi

echo "Found NVMe devices: $NVME_DEVICES"

# For each NVMe device
for DEVICE in $NVME_DEVICES; do
  echo "Configuring $DEVICE..."
  
  # Set IO scheduler to none (best for NVMe)
  if [ -f /sys/block/$DEVICE/queue/scheduler ]; then
    echo "none" > /sys/block/$DEVICE/queue/scheduler
    echo "Set scheduler to: $(cat /sys/block/$DEVICE/queue/scheduler)"
  fi
  
  # Set read ahead to 1MB
  if [ -f /sys/block/$DEVICE/queue/read_ahead_kb ]; then
    echo 1024 > /sys/block/$DEVICE/queue/read_ahead_kb
    echo "Set read_ahead_kb to: $(cat /sys/block/$DEVICE/queue/read_ahead_kb)"
  fi
  
  # Disable add_random (not needed for SSDs)
  if [ -f /sys/block/$DEVICE/queue/add_random ]; then
    echo 0 > /sys/block/$DEVICE/queue/add_random
    echo "Disabled add_random"
  fi

done

# Check if fstrim service is enabled
if systemctl list-unit-files | grep -q fstrim.timer; then
  echo "Enabling weekly TRIM for SSD optimization"
  systemctl enable fstrim.timer
  systemctl start fstrim.timer
fi

# Make changes permanent
cat > /etc/udev/rules.d/60-nvme-scheduler.rules << EOF
# Set scheduler to none and read ahead to 1MB for NVMe drives
ACTION=="add|change", KERNEL=="nvme[0-9]*n[0-9]*", ATTR{queue/scheduler}="none", ATTR{queue/read_ahead_kb}="1024", ATTR{queue/add_random}="0"
EOF

echo "NVMe optimization complete. Changes will persist after reboot." 