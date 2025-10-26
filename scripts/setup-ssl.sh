#!/bin/bash

# SSL Setup Script for Amnesiac Server
# This script sets up HTTPS with self-signed SSL certificate for IP-based access
# Usage: sudo ./setup-ssl.sh

set -e  # Exit on any error

echo "🔒 Setting up HTTPS for Amnesiac Server..."

# Get the server's public IP
SERVER_IP=$(curl -s http://ifconfig.me || echo "64.225.49.223")
echo "📡 Detected server IP: $SERVER_IP"

# Update system packages
echo "📦 Updating system packages..."
apt update && apt upgrade -y

# Install Nginx and OpenSSL
echo "🔧 Installing Nginx and SSL tools..."
apt install nginx openssl -y

# Stop any existing web servers on port 80/443
echo "🛑 Stopping any conflicting services..."
systemctl stop apache2 2>/dev/null || true
systemctl stop nginx 2>/dev/null || true

# Create SSL directory
mkdir -p /etc/ssl/amnesiac

# Generate self-signed SSL certificate
echo "🔐 Generating SSL certificate for IP: $SERVER_IP"
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/amnesiac/server.key \
    -out /etc/ssl/amnesiac/server.crt \
    -subj "/C=US/ST=DigitalOcean/L=Cloud/O=Amnesiac/OU=API/CN=$SERVER_IP" \
    -addext "subjectAltName=IP:$SERVER_IP"

# Set proper permissions
chmod 600 /etc/ssl/amnesiac/server.key
chmod 644 /etc/ssl/amnesiac/server.crt

# Create Nginx configuration for both HTTP and HTTPS
echo "⚙️ Configuring Nginx..."
tee /etc/nginx/sites-available/amnesiac-api > /dev/null <<EOF
# HTTP server - redirect to HTTPS
server {
    listen 80;
    server_name $SERVER_IP _;
    return 301 https://\$server_name\$request_uri;
}

# HTTPS server - proxy to Node.js app
server {
    listen 443 ssl http2;
    server_name $SERVER_IP _;

    # SSL Configuration
    ssl_certificate /etc/ssl/amnesiac/server.crt;
    ssl_certificate_key /etc/ssl/amnesiac/server.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384;
    ssl_prefer_server_ciphers off;

    # Proxy to Node.js application on port 3000
    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        proxy_cache_bypass \$http_upgrade;
        
        # CORS headers for API access
        add_header Access-Control-Allow-Origin * always;
        add_header Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS" always;
        add_header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept, Authorization" always;
        
        # Handle preflight requests
        if (\$request_method = 'OPTIONS') {
            add_header Access-Control-Allow-Origin * always;
            add_header Access-Control-Allow-Methods "GET, POST, PUT, DELETE, OPTIONS" always;
            add_header Access-Control-Allow-Headers "Origin, X-Requested-With, Content-Type, Accept, Authorization" always;
            add_header Access-Control-Max-Age 1728000;
            add_header Content-Type 'text/plain charset=UTF-8';
            add_header Content-Length 0;
            return 204;
        }
    }
}
EOF

# Enable the site and disable default
ln -sf /etc/nginx/sites-available/amnesiac-api /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# Test Nginx configuration
echo "🧪 Testing Nginx configuration..."
nginx -t

# Start and enable Nginx
echo "🚀 Starting Nginx..."
systemctl start nginx
systemctl enable nginx

# Check if Node.js app is running
if ! pgrep -f "node.*app.js\|bun.*app.ts" > /dev/null; then
    echo "⚠️  Node.js app doesn't appear to be running on port 3000"
    echo "   Make sure your Amnesiac server is started with PM2"
fi

# Test the HTTPS connection
echo "🔍 Testing HTTPS connection..."
sleep 2
if curl -k -s https://$SERVER_IP/health > /dev/null; then
    echo "✅ HTTPS is working!"
else
    echo "❌ HTTPS test failed - check logs with: sudo journalctl -u nginx"
fi

echo ""
echo "🎉 SSL setup complete!"
echo ""
echo "� Your API is now available at:"
echo "   🔓 HTTP:  http://$SERVER_IP (redirects to HTTPS)"
echo "   🔒 HTTPS: https://$SERVER_IP"
echo ""
echo "🔧 Update your GitHub repository secrets:"
echo "   PUBLIC_API_URL: https://$SERVER_IP"
echo "   PUBLIC_API_BASE_URL: https://$SERVER_IP/api"
echo ""
echo "⚠️  Note: Browsers will show a security warning for self-signed certificates."
echo "   Users need to click 'Advanced' → 'Proceed to $SERVER_IP (unsafe)'"
echo ""
echo "📝 To check status:"
echo "   sudo systemctl status nginx"
echo "   sudo nginx -t"
echo "   curl -k https://$SERVER_IP/health"