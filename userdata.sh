#!/bin/bash
# Update and install Apache
sudo apt update -y
sudo apt install -y apache2

# Configure Apache to listen on port 8000
sudo sed -i 's/Listen 80/Listen 8000/' /etc/apache2/ports.conf
sudo sed -i 's/<VirtualHost *:80>/<VirtualHost *:8000>/' /etc/apache2/sites-available/000-default.conf

# Create an index.html file
echo "<html><body><h1>Hello this is Koushal testing on port 8000!</h1></body></html>" | sudo tee /var/www/html/index.html

# Restart Apache to apply changes
sudo systemctl restart apache2
