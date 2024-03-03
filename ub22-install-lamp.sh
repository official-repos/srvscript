#!/bin/bash

# Update package lists
sudo apt update

# Install Apache
sudo apt install apache2 -y

# Install MySQL
sudo apt install mysql-server -y

# Install PHP and required modules
sudo apt install php libapache2-mod-php php-mysql php-cli php-curl php-gd php-json php-mbstring php-xml php-zip -y

# Enable Apache modules
sudo a2enmod ssl
sudo a2enmod rewrite
sudo a2enmod remoteip

# Restart Apache
sudo systemctl restart apache2

# Install phpMyAdmin
sudo apt install phpmyadmin -y

# Configure phpMyAdmin with Apache
#sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
#sudo a2enconf phpmyadmin.conf
#sudo systemctl reload apache2

# Enable mod_remoteip
echo "<IfModule mod_remoteip.c>
    RemoteIPHeader X-Forwarded-For
</IfModule>" | sudo tee /etc/apache2/conf-available/remoteip.conf

# Enable remoteip configuration
sudo a2enconf remoteip

# Enable SSL configuration
sudo a2ensite default-ssl

# Allow Read/Write for Owner
sudo chmod -R 0755 /var/www/html/

# Restart Apache to apply changes
sudo systemctl restart apache2

# Configure firewall
echo "Adjusting Firewall"
sudo ufw allow in "Apache Full"
sudo ufw reload
echo "Enabling SSL"

echo "LAMP stack, phpMyAdmin, mod_rewrite, and mod_remoteip installed successfully!"


