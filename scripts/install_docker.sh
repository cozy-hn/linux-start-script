#!/bin/bash

# Exit on error
set -e

echo "Installing Docker..."

# Install prerequisites
if command -v apt-get >/dev/null 2>&1; then
    # Debian/Ubuntu
    echo "Detected Debian/Ubuntu system"

    # Update package index
    apt-get update

    # Install required packages
    apt-get install -y \
        ca-certificates \
        curl \
        gnupg \
        lsb-release

    # Add Docker's official GPG key
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    # Set up the repository
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

    # Install Docker Engine
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

elif command -v yum >/dev/null 2>&1; then
    # CentOS/RHEL
    echo "Detected CentOS/RHEL system"

    # Install required packages
    yum install -y yum-utils

    # Add Docker repository
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

    # Install Docker Engine
    yum install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

elif command -v dnf >/dev/null 2>&1; then
    # Fedora
    echo "Detected Fedora system"

    # Install required packages
    dnf -y install dnf-plugins-core

    # Add Docker repository
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

    # Install Docker Engine
    dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

else
    echo "Unsupported package manager. Please install Docker manually."
    exit 1
fi

# Start and enable Docker service
systemctl start docker
systemctl enable docker

# Verify Docker installation
docker --version
docker compose version

echo "Docker installation completed successfully."
echo ""
echo "Usage examples:"
echo "  - Run a container: docker run hello-world"
echo "  - List containers: docker ps"
echo "  - List images: docker images"
echo "  - Docker Compose: docker compose up -d"
echo ""
echo "To use Docker without sudo, add your user to the docker group:"
echo "  sudo usermod -aG docker \$USER"
echo "  (Then log out and back in for changes to take effect)"
