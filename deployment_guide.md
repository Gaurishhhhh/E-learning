# E-Learning Platform Deployment Guide for AWS EC2

## Prerequisites
- AWS Account
- Basic knowledge of AWS EC2
- Domain name (optional, but recommended)

## 1. EC2 Instance Setup

1. Launch a new EC2 instance:
   - Choose Ubuntu Server 22.04 LTS
   - t2.micro for testing, t2.small or better for production
   - Configure Security Group:
     ```
     HTTP (80)   : 0.0.0.0/0
     HTTPS (443) : 0.0.0.0/0
     SSH (22)    : Your-IP/32
     ```

2. Connect to your instance:
   ```bash
   ssh -i your-key.pem ubuntu@your-instance-ip
   ```

## 2. System Setup

1. Update system packages:
   ```bash
   sudo apt update
   sudo apt upgrade -y
   ```

2. Install required system packages:
   ```bash
   sudo apt install -y python3-pip python3-dev build-essential libssl-dev libffi-dev python3-setuptools python3-venv nginx
   ```

## 3. Application Setup

1. Create application directory:
   ```bash
   sudo mkdir /var/www/elearning
   sudo chown ubuntu:ubuntu /var/www/elearning
   ```

2. Create and activate virtual environment:
   ```bash
   cd /var/www/elearning
   python3 -m venv venv
   source venv/bin/activate
   ```

3. Install required Python packages:
   ```bash
   pip install -r requirements.txt
   pip install gunicorn
   ```

4. Create and set environment variables in .env file:
   ```bash
   sudo nano /var/www/elearning/.env
   ```
   Add the following:
   ```
   SECRET_KEY=your-secure-secret-key
   DATABASE_URL=sqlite:///elearning.db
   MAIL_USERNAME=your-email@gmail.com
   MAIL_PASSWORD=your-app-specific-password
   ```

5. Create uploads directory:
   ```bash
   mkdir -p /var/www/elearning/static/uploads
   chmod 755 /var/www/elearning/static/uploads
   ```

## 4. Gunicorn Setup

1. Create Gunicorn systemd service:
   ```bash
   sudo nano /etc/systemd/system/elearning.service
   ```
   Add the following:
   ```ini
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
   ```

2. Start and enable the service:
   ```bash
   sudo systemctl start elearning
   sudo systemctl enable elearning
   ```

## 5. Nginx Setup

1. Create Nginx configuration:
   ```bash
   sudo nano /etc/nginx/sites-available/elearning
   ```
   Add the following:
   ```nginx
   server {
       listen 80;
       server_name your-domain.com;  # Or your EC2 public IP

       location /static {
           alias /var/www/elearning/static;
       }

       location / {
           proxy_pass http://127.0.0.1:8000;
           proxy_set_header Host $host;
           proxy_set_header X-Real-IP $remote_addr;
           proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
           proxy_set_header X-Forwarded-Proto $scheme;
           client_max_body_size 16M;
       }
   }
   ```

2. Enable the site:
   ```bash
   sudo ln -s /etc/nginx/sites-available/elearning /etc/nginx/sites-enabled
   sudo nginx -t
   sudo systemctl restart nginx
   ```

## 6. Database Setup

1. Initialize the database:
   ```bash
   cd /var/www/elearning
   source venv/bin/activate
   flask db upgrade
   ```

2. Create admin user:
   ```bash
   python3 create_admin.py
   ```

## 7. SSL Setup (Optional but Recommended)

1. Install Certbot:
   ```bash
   sudo snap install --classic certbot
   sudo ln -s /snap/bin/certbot /usr/bin/certbot
   ```

2. Obtain SSL certificate:
   ```bash
   sudo certbot --nginx -d your-domain.com
   ```

## Maintenance

1. View application logs:
   ```bash
   sudo journalctl -u elearning.service
   ```

2. Restart application:
   ```bash
   sudo systemctl restart elearning
   ```

3. Check status:
   ```bash
   sudo systemctl status elearning
   ```

## Important Notes

1. Make sure to replace placeholder values:
   - your-domain.com with your actual domain
   - your-secure-secret-key with a strong secret key
   - email credentials with valid Gmail credentials

2. The default setup uses SQLite. For production, consider using:
   - PostgreSQL
   - Regular backups
   - Proper monitoring

3. Security considerations:
   - Keep system packages updated
   - Use strong passwords
   - Regularly monitor logs
   - Configure firewall rules properly
   - Keep SSL certificates up to date
