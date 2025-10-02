# Linux Base Setting

Tired of setting up Linux servers from scratch every month? Me too! 

This repo saves you from the pain of remembering those pesky commands.

## Why This Exists

Because typing the same commands over and over is boring, and asking ChatGPT every time is just extra work.

## Copy to Your Server

First, copy these files to your server:

```bash
# Using SSH key authentication
scp -i /path/to/your/key.pem -r path/to/this/repo user@your-server-ip:~/
```

## Quick Setup

You can use individual scripts for specific tasks:

```bash
# Make scripts executable
chmod +x scripts/*.sh

# Update your system
./scripts/update_system.sh

# Install build essentials
./scripts/install_essentials.sh

# Install common tools (git, curl, wget, vim)
./scripts/install_common_tools.sh

# Setup firewall (SSH, HTTP, HTTPS ports open)
./scripts/firewall.sh

# Install htop (system monitoring tool)
./scripts/install_monitoring.sh

# Install iotop (I/O monitoring tool)
./scripts/install_iotop.sh

# Install tmux (terminal multiplexer)
./scripts/install_tmux.sh

# Install unzip utility
./scripts/install_unzip.sh

# Install aria2 download manager
./scripts/install_aria2.sh

# Install LZ4 compression tools
./scripts/install_lz4.sh

# Install jq (JSON processor)
./scripts/install_jq.sh

# Install Docker (container platform)
sudo ./scripts/install_docker.sh

# Install Ookla Speedtest CLI
./scripts/install_speedtest.sh

# Disable SSH password authentication (key-based login only)
# WARNING: Run this ONLY after adding your SSH key to the server!
sudo ./scripts/secure_ssh.sh

# Set lower swappiness (default: 10, uses memory more, swaps less)
# You can specify a custom value: sudo ./scripts/set_swappiness.sh 20
sudo ./scripts/set_swappiness.sh
```

## Performance Optimization

Optimize your server's hardware performance:
```
You have to fix this script for your server spec

My server spec
- CPU: Intel Xeon W-2295
- RAM: 4x RAM 32768 MB DDR4
- SSD: 1x SSD U.2 NVMe 3.84 TB
- Network: Intel I210
```
```bash
# Optimize NVMe SSD performance
sudo ./scripts/optimize_nvme.sh

# Optimize network performance (especially for Intel I210 NIC)
sudo ./scripts/optimize_network.sh

# Optimize for high RAM systems (128GB+)
sudo ./scripts/optimize_ram.sh
```

## Usage

Just clone, make executable, and run the scripts you need. That's it. No more forgetting commands.
