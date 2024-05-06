#!/usr/bin/env bash

# Install Nginx if not already installed
if ! command -v nginx &>/dev/null; then
    sudo apt-get update
    sudo apt-get -y install nginx
fi

# Create necessary directories
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared /data/web_static/current

# Create a fake HTML file
echo "<html><head></head><body>Test page</body></html>" | sudo tee /data/web_static/releases/test/index.html >/dev/null

# Create symbolic link if it doesn't exist, delete and recreate otherwise
sudo ln -sf /data/web_static/releases/test /data/web_static/current

# Set ownership of the /data/ folder to ubuntu user and group recursively
sudo chown -R ubuntu:ubuntu /data/

# Update Nginx configuration
sudo sed -i '/server_name _;/a \\n\tlocation /hbnb_static {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default

# Restart Nginx
sudo service nginx restart

exit 0
