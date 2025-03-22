# INSTRUCTIONS:
# - change your domain name
# - create user cert-access to use for managing certificates
# if you need to do more you probably know.


# Stop and disable Apache
sudo systemctl stop apache2.service
sudo systemctl disable apache2.service

# Stop and disable lighttpd
sudo systemctl stop lighttpd.service
sudo systemctl disable lighttpd.service

# Kill any remaining process on port 80
pid=$(sudo fuser 80/tcp 2>/dev/null | cut -d':' -f2 | tr -d ' ')
if [ ! -z "$pid" ]; then
    sudo kill -9 $pid
fi

# Obtain SSL certificate
sudo certbot certonly --standalone -d www.example.com

# Enable and start lighttpd
sudo systemctl enable lighttpd.service
sudo systemctl start lighttpd.service

# Enable and start Apache
sudo systemctl enable apache2.service
sudo systemctl start apache2.service

# Reload systemd daemon
sudo systemctl daemon-reload

# Give access to new cert files
sudo chmod 644 /etc/letsencrypt/live/*/*.pem
sudo chown -R root:cert-access /etc/letsencrypt/live
