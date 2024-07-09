
# Traefik Installation Script (docker compose) (DNS provider: cloudflare)

This repository contains a script and configuration files to automate the installation and setup of Traefik 2.6, following IBRACORP's tutorial. The scripts will configure Traefik to use Cloudflare as the DNS provider for external services. Follow the steps below to configure and run the automation scripts.  Link:  https://docs.ibracorp.io/traefik/master/docker-compose

## Explanation

### Purpose

The purpose of this repository is to automate the setup and management of Traefik for external services, using Cloudflare as the DNS provider. This helps in installing traefik per the instructions provided by YouTuber IBRACORP using docker compose.
Link to IBRACORP's instructions for Traefik 2.6 using Docker Compse.  https://docs.ibracorp.io/traefik/master/docker-compose

### How It Works

- The `setup_traefik_docker_compose.sh` script prepares the host environment, sets up Traefik, and has the configuration files prepated from traefik to work with Cloudflare.

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

### 2. Run the Setup Script

Make the `setup_traefik_docker_compose.sh` script executable and run it:

```bash
chmod +x setup_traefik_docker_compose.sh
./setup_traefik_docker_compose.sh
```

The script will prompt you for your **domain name**.  Please enter like this: yourdomain.com
Your domain name will be updated where necessary in the traefik appdata files (traefik.yml, config.yml, and docker-compose.yml).

The script will then prompt you for your **host ip address**.  Please enter like this: 10.10.0.100 (without http://)
Your host IP address is actually only in one place in the dynamic config file (config.yml) wherein it points to sample Plex container at HOST_IP_ADDRESS:32400

### 3. Configure Environment Variables (update /opt/appdata/traefik/.env)

Edit the `.env` file in the root directory of the repository with the following content:

```dotenv
EMAIL=your_email@example.com
TRAEFIK_CF_DNS_API_TOKEN=your_cloudflare_api_token
```
Replace `your_cloudflare_api_token` and 'your_email@example.com' with your actual Cloudflare API token and the email address associated with Cloudflare.
There is a section below describing how to Obtain a Cloudflare API Token.

### 4. Start Traefik with Docker Compose

Finally, start Traefik using Docker Compose:

```bash
docker-compose up -d
```
### 5. Start to Use Traefik to Access Local Services Remotely

You will find the Traefik dashboard accessible at http://your-host-ip:8083. (Port 8083 is used instead of the default 8080, as 8080 is a common port that other containers may be using.)

Refer to IBRACORP's instructions for adding services using Docker Labels. Otherwise, see config.yml for a template Router and Service pair for adding services manually.

Refer to **update_traefik_and_cloudflare** (link: https://github.com/jdepew88/update_traefik_and_cloudflare) for a script to automate the process of adding services to Traefik's dynamic config (config.yml) and automatically adding CNAME records in Cloudflare.

### DNS and Port Forwarding Configuration
You will need to configure your DNS records with Cloudflare. For further information on setting up A and CNAME records in Cloudflare or using a Cloudflare tunnel, refer to IBRACORP's documentation.

Additionally, you will need to set your router to use NAT/Port Forwarding. Note: HTTP and HTTPS requests to your server will come in on WAN ports 80 and 443. You will need to set your redirect target IP to your Traefik Host IP and the redirect ports to 8001 and 44301 for use with this script.

You can always edit the Docker Compose file before running docker-compose up -d to change ports. For example, you can change ports to 443:443 and 80:80 if you prefer a simpler NAT configuration.


## Obtaining a Cloudflare API Token for Let's Encrypt

1. **Log in to Cloudflare**:
   - Go to [Cloudflare](https://www.cloudflare.com) and log in to your account.

2. **Navigate to API Tokens**:
   - Click on your profile icon in the top right corner and select **My Profile**.
   - In the left sidebar, click on **API Tokens**.

3. **Create a New API Token**:
   - Click on the **Create Token** button.
   - Use the **Edit zone DNS** template.

4. **Configure the Token**:
   - Under **Zone Resources**, select **Include** > **Specific zone** > choose your domain.
   - Under **Permissions**, set **Zone** > **DNS** > **Edit**.

5. **Create and Copy the Token**:
   - Give your token a name (e.g., "Let's Encrypt DNS Token").
   - Click **Continue to summary**, review the settings, and click **Create Token**.
   - Copy the generated API token and store it securely.


## Contributing

Feel free to fork this repository, make changes, and submit pull requests. Any contributions are welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
