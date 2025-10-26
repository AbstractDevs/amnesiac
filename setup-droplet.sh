#!/bin/bash
# DigitalOcean Droplet Setup Script for Amnesiac Server
# Run this script on your droplet after initial creation

set -e

echo "🚀 Setting up Amnesiac Server on DigitalOcean..."

# Update system packages
echo "📦 Updating system packages..."
sudo apt update && sudo apt upgrade -y

# Install Node.js 18
echo "📦 Installing Node.js 18..."
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Bun
echo "📦 Installing Bun..."
curl -fsSL https://bun.sh/install | bash
echo 'export PATH="$HOME/.bun/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Make bun available system-wide
sudo ln -s ~/.bun/bin/bun /usr/local/bin/bun

# Install PM2 globally
echo "📦 Installing PM2..."
sudo npm install -g pm2

# Create application directory
echo "📁 Creating application directory..."
sudo mkdir -p /var/www/amnesiac-server
sudo chown $USER:$USER /var/www/amnesiac-server

# Setup PM2 to start on boot
echo "⚙️ Setting up PM2 startup..."
pm2 startup

echo ""
echo "✅ Setup complete!"
echo ""
echo "Next steps:"
echo "1. Run the command that PM2 startup provided (if any)"
echo "2. Add GitHub Secrets in your repository:"
echo "   - DO_HOST: $(curl -s ifconfig.me)"
echo "   - DO_USERNAME: $USER"
echo "   - DO_SSH_KEY: Your private SSH key content"
echo "3. Push changes to trigger deployment"
echo ""
echo "Server will be available at: http://$(curl -s ifconfig.me):3000"
echo "Health check: http://$(curl -s ifconfig.me):3000/health"