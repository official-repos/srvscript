#!/bin/bash

# Update apt package index
sudo apt update

# Install Apache, MySQL, PHP, and other required packages
sudo apt install -y apache2 mysql-server php libapache2-mod-php php-mysql phpmyadmin

# Enable Apache modules
sudo a2enmod ssl rewrite remoteip

# Enable SSL configuration
sudo a2ensite default-ssl

# Restart Apache to apply changes
sudo systemctl restart apache2

# Secure MySQL installation
sudo mysql_secure_installation

echo "LAMP stack, phpMyAdmin, and required Apache modules installed successfully."
