#!/bin/bash

# Update package list and upgrade the system
echo "Updating package list and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages for Docker
echo "Installing necessary packages for Docker..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker’s official GPG key
echo "Adding Docker’s official GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker stable repository
echo "Setting up the Docker stable repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker
echo "Starting and enabling Docker..."
sudo systemctl start docker
sudo systemctl enable docker

# Download the Docker Compose binary
echo "Downloading Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '(?<=\"tag_name\": \")[^\"]*')/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Apply executable permissions to the Docker Compose binary
echo "Applying executable permissions to Docker Compose..."
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
echo "Verifying Docker Compose installation..."
docker-compose --version

# Install Nano text editor
echo "Installing Nano text editor..."
sudo apt install -y nano

# Create a custom Docker network for Traefik
echo "Creating custom Docker network 'proxy'..."
docker network create proxy

# Create the Traefik folder in appdata
echo "Creating Traefik folder in appdata..."
mkdir -p /opt/appdata/traefik

# Create the acme.json file and apply the correct permissions
echo "Creating acme.json file and setting permissions..."
touch /opt/appdata/traefik/acme.json
chmod 600 /opt/appdata/traefik/acme.json

# Download and extract files from the GitHub repository
echo "Downloading and extracting files from the GitHub repository..."
cd /opt/appdata/traefik
sudo apt install -y git
git clone https://github.com/jdepew88/install_traefik_compose.git .
rm -rf install_traefik_compose

echo "Traefik initial setup for Docker Compose completed. Please run the next script to complete the setup."

echo "Credit: This script is based on instructions from IBRACORP. For more details, visit: https://docs.ibracorp.io/traefik/master/docker-compose"
