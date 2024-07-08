#!/bin/bash

# Prompt for Let's Encrypt email
read -p "Enter your email for Let's Encrypt: " EMAIL

# Prompt for domain name
read -p "Enter your domain name: " DOMAIN_NAME

# Prompt for Cloudflare API token
read -p "Enter your Cloudflare API token: " CLOUDFLARE_API_TOKEN

# Create the .env file with the provided information
cat <<EOL > /opt/appdata/traefik/.env
# Let's Encrypt email
EMAIL=$EMAIL

# Your main domain
DOMAIN_NAME=$DOMAIN_NAME

# Cloudflare API token
CLOUDFLARE_API_TOKEN=$CLOUDFLARE_API_TOKEN
EOL

echo ".env file created with the provided information."

echo "Traefik setup for Docker Compose completed. You can now start Traefik using Docker Compose."
