# HTTPS Setup Instructions

## Quick Setup (One Command)

SSH into your DigitalOcean server and run:

```bash
# Download and run the SSL setup script
curl -fsSL https://raw.githubusercontent.com/AbstractDevs/amnesiac/main/scripts/setup-ssl.sh | sudo bash
```

## Manual Setup (Alternative)

If you prefer to review the script first:

```bash
# 1. Download the script
wget https://raw.githubusercontent.com/AbstractDevs/amnesiac/main/scripts/setup-ssl.sh

# 2. Review the script (optional)
cat setup-ssl.sh

# 3. Make it executable and run
chmod +x setup-ssl.sh
sudo ./setup-ssl.sh
```

## After Running the Script

1. **Update GitHub Secrets**: Go to your repository settings and update:
   - `PUBLIC_API_URL`: `https://64.225.49.223`
   - `PUBLIC_API_BASE_URL`: `https://64.225.49.223/api`

2. **Trigger Deployment**: Push any change to trigger a new web app deployment

3. **Test HTTPS**: Visit `https://64.225.49.223/health` (accept the security warning)

## What the Script Does

- ✅ Installs and configures Nginx as reverse proxy
- ✅ Generates self-signed SSL certificate for your server IP
- ✅ Sets up HTTPS with proper CORS headers
- ✅ Redirects HTTP traffic to HTTPS
- ✅ Tests the configuration

## Security Warning

The script uses a self-signed certificate, so browsers will show a security warning. Users will need to click "Advanced" → "Proceed to [IP] (unsafe)" to access the site.

For production use, consider getting a domain name and using Let's Encrypt for a proper SSL certificate.