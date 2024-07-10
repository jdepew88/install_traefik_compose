#!/bin/bash

# Prompt user for domain name
read -p "Enter your domain name (e.g., example.com): " DOMAIN_NAME

# Prompt user for host IP address
read -p "Enter your host IP address (e.g., 10.10.0.100): " HOST_IP_ADDRESS

# Prompt user for email address
read -p "Enter your email address (e.g., user@example.com): " EMAIL

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
cp -r install_traefik_compose/traefik/* /opt/appdata/traefik/
cp -r install_traefik_compose/traefik/.* /opt/appdata/traefik/  # Copy hidden files including .env
rm -rf install_traefik_compose

# Update traefik.yml, docker-compose.yml, and config.yml with the provided domain name
sed -i "s/\${DOMAIN_NAME}/$DOMAIN_NAME/g" /opt/appdata/traefik/traefik.yml
sed -i "s/\${DOMAIN_NAME}/$DOMAIN_NAME/g" /opt/appdata/traefik/docker-compose.yml
sed -i "s/\${DOMAIN_NAME}/$DOMAIN_NAME/g" /opt/appdata/traefik/config.yml

# Update traefik.yml with the provided email address
sed -i "s/\${EMAIL}/$EMAIL/g" /opt/appdata/traefik/traefik.yml

# Update config.yml with the provided host IP address
sed -i "s/HOST_IP_ADDRESS/$HOST_IP_ADDRESS/g" /opt/appdata/traefik/config.yml

# Notify the user to edit the .env file
echo "Please edit the .env file with your specific details, such as Cloudflare API token and email."

# Notify the user to complete the setup by running docker compose up
echo "Traefik initial setup for Docker Compose completed. Please run 'docker-compose up -d' to complete the setup after you edit the .env file."

echo "Credit: This script is based on instructions from IBRACORP. For more details, visit: https://docs.ibracorp.io/traefik/master/docker-compose"
