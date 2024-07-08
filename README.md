
# Traefik Installation Script (docker compose) (DNS provider: cloudflare)

This repository contains scripts and configuration files to automate the installation and setup of Traefik 2.6, following IBRACORP's tutorial. The scripts will configure Traefik to use Cloudflare as the DNS provider for external services. Follow the steps below to configure and run the automation scripts.  Link:  https://docs.ibracorp.io/traefik/master/docker-compose

## Prerequisites

- Docker and Docker Compose installed
- Python 3.6 or higher installed
- Cloudflare account

## Setup

### 1. Clone the Repository

Clone this repository to your local machine.

```bash
git clone https://github.com/jdepew88/install_traefik_compose.git
cd install_traefik_compose
```

### 2. Configure Environment Variables (sample in repo - .env)

Create a `.env` file in the root directory of the repository with the following content:

```dotenv
# Cloudflare configuration
CLOUDFLARE_API_TOKEN=your_cloudflare_api_token
CLOUDFLARE_ZONE_ID=your_cloudflare_zone_id

# Your main domain
DOMAIN_NAME=your-domain.com

# Config file path
CONFIG_FILE_PATH=/opt/appdata/traefik/config.yml
```

Replace `your_cloudflare_api_token`, `your_cloudflare_zone_id`, and `your-domain.com` with your actual Cloudflare API token, zone ID, and domain name, respectively.

### 3. Run the Setup Script

Make the `setup_traefik_docker_compose.sh` script executable and run it:

```bash
chmod +x setup_traefik_docker_compose.sh
./setup_traefik_docker_compose.sh
```

### 4. Start Traefik with Docker Compose

Finally, start Traefik using Docker Compose:

```bash
docker-compose up -d
```

### How to add services with update_traefik_and_cloudflare (find in this repo)

When you run the script, it will ask you three questions:

1. **Enter the name of your service:** 
   - This is the name you want to use for your new service.
   - Example: `plex`

2. **Enter the IP address of `<service_name>`:**
   - This is the IP address and port where your service is running.
   - Example: `10.10.0.100:32800`

3. **Enter the scheme (http or https) for the service:**
   - This specifies whether your service uses HTTP or HTTPS.
   - Example: `http`

Based on your inputs, the script will:
- Create a new router entry in the Traefik configuration for the service.
- Create a new service entry in the Traefik configuration pointing to the specified IP address and scheme.
- Update the configuration file and create a backup.
- Add a CNAME record to Cloudflare to point to your main domain.

## Obtaining a Cloudflare API Token and Setting Up Zone Settings

### Step 1: Create a Cloudflare API Token

1. Log in to your Cloudflare account.
2. Navigate to the "My Profile" page by clicking on your profile icon in the top right corner and selecting "My Profile".
3. Click on the "API Tokens" tab.
4. Click on the "Create Token" button.
5. Use the "Edit zone DNS" template under the "API Token Templates" section.
6. Configure the token with the necessary permissions:
   - Zone: DNS: Edit
7. Click "Continue to summary", review the token settings, and then click "Create Token".
8. Copy the generated API token and store it securely. You'll need it for the `.env` file.

### Step 2: Configure Zone Settings

1. Log in to your Cloudflare account and go to the "Dashboard".
2. Select your domain from the list of zones.
3. Navigate to the "DNS" tab.
4. Ensure that the domain is using Cloudflare's nameservers.
5. Make sure your domain's DNS settings are properly configured to use Cloudflare's DNS services.

## Explanation

### Purpose

The purpose of this repository is to automate the setup and management of Traefik for external services, using Cloudflare as the DNS provider. This helps in installing traefik per the instructions provided by YouTuber IBRACORP using docker compose.

### How It Works

- The `setup_traefik_docker_compose.sh` script prepares the host environment, sets up Traefik, and has the configuration files to work with Cloudflare.

## Contributing

Feel free to fork this repository, make changes, and submit pull requests. Any contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
