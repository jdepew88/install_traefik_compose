#!/bin/bash

# Update package list and upgrade the system
echo "Updating package list and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages
echo "Installing necessary packages..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release git

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
git clone https://github.com/jdepew88/install_traefik_compose.git
cp -r install_traefik_compose/traefik/* .
rm -rf install_traefik_compose

echo "Traefik initial setup for Docker Compose completed. Please run the next script to complete the setup."

echo "Credit: This script is based on instructions from IBRACORP. For more details, visit: https://docs.ibracorp.io/traefik/master/docker-compose"
