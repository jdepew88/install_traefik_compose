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

echo "acme.json file created and permissions set."

echo "Credit: This script is based on instructions from IBRACORP. For more details, visit: https://docs.ibracorp.io/traefik/master/docker-compose"
