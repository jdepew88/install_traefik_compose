#!/bin/bash

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

# Open nano text editor to create the docker-compose file
echo "Opening nano to create the docker-compose.yml file..."
nano /opt/appdata/traefik/docker-compose.yml

echo "Traefik initial setup for Docker Compose completed."

echo "Credit: This script is based on instructions from IBRACORP. For more details, visit: https://docs.ibracorp.io/traefik/master/docker-compose"
