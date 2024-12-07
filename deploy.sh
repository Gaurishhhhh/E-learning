#!/bin/bash

# Exit on error
set -e

echo "Starting deployment process..."

# Update system
echo "Updating system packages..."
sudo apt update
sudo apt upgrade -y

# Install required packages
echo "Installing required system packages..."
sudo apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools python3-venv nginx

# Create application directory
echo "Setting up application directory..."
sudo mkdir -p /var/www/elearning
sudo chown ubuntu:ubuntu /var/www/elearning

# Setup virtual environment
echo "Setting up Python virtual environment..."
cd /var/www/elearning
python3 -m venv venv
source venv/bin/activate

# Install Python packages
echo "Installing Python packages..."
pip install -r requirements.txt
pip install gunicorn

# Create uploads directory
echo "Creating uploads directory..."
mkdir -p /var/www/elearning/static/uploads
chmod 755 /var/www/elearning/static/uploads

# Setup Gunicorn service
echo "Setting up Gunicorn service..."
sudo tee /etc/systemd/system/elearning.service << EOF
[Unit]
Description=E-Learning Platform
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/var/www/elearning
Environment="PATH=/var/www/elearning/venv/bin"
ExecStart=/var/www/elearning/venv/bin/gunicorn -w 4 -b 127.0.0.1:8000 wsgi:app

[Install]
WantedBy=multi-user.target
EOF

# Setup Nginx
echo "Setting up Nginx configuration..."
sudo tee /etc/nginx/sites-available/elearning << EOF
server {
    listen 80;
    server_name \$host;

    location /static {
        alias /var/www/elearning/static;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
        client_max_body_size 16M;
    }
}
EOF

# Enable Nginx site
sudo ln -s /etc/nginx/sites-available/elearning /etc/nginx/sites-enabled
sudo nginx -t
sudo systemctl restart nginx

# Start and enable Gunicorn service
echo "Starting Gunicorn service..."
sudo systemctl start elearning
sudo systemctl enable elearning

# Initialize database
echo "Initializing database..."
flask db upgrade

echo "Deployment completed successfully!"
echo "Please make sure to:"
echo "1. Set up your environment variables in /var/www/elearning/.env"
echo "2. Create an admin user using create_admin.py"
echo "3. Configure SSL using Certbot if needed"
