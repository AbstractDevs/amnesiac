#!/bin/bash

# Diagnostic script to check SSL/HTTPS setup
echo "🔍 Diagnosing HTTPS setup..."
echo

# Check if Nginx is running
echo "1. Nginx status:"
systemctl status nginx --no-pager -l

echo
echo "2. What's listening on ports 80, 443, and 3000:"
netstat -tlnp | grep -E ':80|:443|:3000'

echo
echo "3. Nginx configuration test:"
nginx -t

echo
echo "4. Active Nginx sites:"
ls -la /etc/nginx/sites-enabled/

echo
echo "5. SSL certificate check:"
if [ -f "/etc/ssl/amnesiac/server.crt" ]; then
    echo "✅ SSL certificate exists"
    openssl x509 -in /etc/ssl/amnesiac/server.crt -text -noout | grep -A 5 "Subject:"
else
    echo "❌ SSL certificate NOT found"
fi

echo
echo "6. Testing HTTP vs HTTPS responses:"
echo "HTTP response:"
curl -I http://localhost/health 2>/dev/null | head -5

echo
echo "HTTPS response (local):"
curl -k -I https://localhost/health 2>/dev/null | head -5

echo
echo "7. Nginx error logs (last 10 lines):"
tail -10 /var/log/nginx/error.log

echo
echo "8. Process check:"
echo "Nginx processes:"
ps aux | grep nginx | grep -v grep
echo "Node/Bun processes:"
ps aux | grep -E 'node|bun' | grep -v grep