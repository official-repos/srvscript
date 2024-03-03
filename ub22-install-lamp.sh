#!/bin/bash

# variables, please customize

echo ".....Let's Install Lamp Stack (Apache, MySql and PHP)....."

echo "Installing in progress step 1 of 4"
echo "Updating the repo..."
sudo apt -y update 
clear

echo "Installing in progress step 2 of 4"
sudo apt install -y apache2

clear
echo "Adjusting Firewall"
sudo ufw allow in "Apache Full"
sudo ufw reload
echo "Enabling SSL"

clear
sudo a2enmod ssl
sudo a2ensite default-ssl.conf
echo "Allowing apache to start on boot up"
# Allow to run Apache on boot up
sudo systemctl enable apache2

clear
echo "Installing in progress step 3 of 4"
echo "Installing MySql"
sudo apt install -y mysql-server

clear
echo "Installing in progress step 4 of 4"
echo "Installing PHP"
sudo apt install -y php libapache2-mod-php php-mysql

clear
# Allow Read/Write for Owner
sudo chmod -R 0755 /var/www/html/

clear
# Create info.php for testing php processing
sudo echo "<?php phpinfo(); ?>" > /var/www/html/info.php
clear

# Open localhost in the default browser
# xdg-open "http://localhost"
# xdg-open "http://localhost/info.php"
# clear

echo "Installing in progress step 5 of --"
echo "Installing phpmyadmin"
sudo apt install -y phpmyadmin php-mbstring php-zip php-gd php-json php-curl

clear
echo "Restarting apache2 ..."
sudo systemctl restart apache2

echo "All Done"	
echo "You can secure your mysql by entering following command"
echo "sudo mysql_secure_installation"
echo "Bye"
exit

