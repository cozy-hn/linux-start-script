#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root or with sudo"
  exit 1
fi

echo "Optimizing network performance..."

# Backup current sysctl configuration
cp /etc/sysctl.conf /etc/sysctl.conf.backup.$(date +%Y%m%d%H%M%S)

# Create new network settings
cat >> /etc/sysctl.conf << EOF

# Network performance optimizations
# Increase TCP max buffer size
net.core.rmem_max = 8388608
net.core.wmem_max = 8388608

# Increase Linux autotuning TCP buffer limits
net.ipv4.tcp_rmem = 4096 87380 8388608
net.ipv4.tcp_wmem = 4096 65536 8388608

# Increase number of incoming connections backlog
net.core.netdev_max_backlog = 10000
net.core.somaxconn = 16384

# Enable TCP fast open
net.ipv4.tcp_fastopen = 3

# Enable TCP window scaling
net.ipv4.tcp_window_scaling = 1

# Enable TCP timestamps
net.ipv4.tcp_timestamps = 1

# Enable TCP selective acknowledgements
net.ipv4.tcp_sack = 1

# Increase the maximum amount of option memory buffers
net.core.optmem_max = 40960

# Increase the TCP congestion window
net.ipv4.tcp_congestion_control = cubic
EOF

# Apply changes
sysctl -p

# Enable TCP BBR congestion control if kernel supports it
if modprobe tcp_bbr &>/dev/null; then
  echo "Enabling TCP BBR congestion control algorithm"
  echo "net.ipv4.tcp_congestion_control = bbr" >> /etc/sysctl.conf
  echo "net.core.default_qdisc = fq" >> /etc/sysctl.conf
  sysctl -p
fi

# If it ain't broke, don't fix it)
# # Check the Intel I210 network card and optimize
# NIC_INTERFACES=$(ip -br link | grep -i "up" | grep -v "lo" | awk '{print $1}')

# for IFACE in $NIC_INTERFACES; do
#   echo "Optimizing network interface: $IFACE"

#   # Turn off TCP segmentation offload
#   ethtool -K $IFACE tso off || true
  
#   # Turn on Rx/Tx checksumming
#   ethtool -K $IFACE rx on tx on || true
  
#   # Set Rx/Tx ring parameter
#   ethtool -G $IFACE rx 4096 tx 4096 || true
  
#   # Set interrupt coalescing
#   ethtool -C $IFACE rx-usecs 16 tx-usecs 16 || true
# done

echo "Network optimization complete. Changes will persist after reboot." 