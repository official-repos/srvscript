#!/bin/bash

#clear
#git pull

echo -n "Enter FQDN: "
read FQDN

# Check if input is empty
if [ -z "${FQDN}" ]; then
    echo "No FQDN entered, Exiting..."
    exit 1
fi

# Prompt the user for the username to check
read -p "Enter username to check: " username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "User '$username' exists."
else
    echo "User '$username' does not exist."
    exit 1
fi

echo "Processing virtual host..."


VDIRCFG=/etc/apache2/sites-available/${FQDN}.conf
sudo cp ./files/vhost-template.conf ${VDIRCFG}
sudo sed -i -e "s/___DOMAIN___/${FQDN}/g" ${VDIRCFG}

VDIR=/var/www/${FQDN}
# Check if the directory exists
if [ ! -d "$VDIR" ]; then
    # If it doesn't exist, create it
    sudo mkdir -p "$VDIR/html"
    echo "<?php phpinfo(); ?>" | sudo tee ${VDIR}/html/test-phpinfo.php
    sudo chown ${username}.${username} ${VDIR}/html -R
    echo "Directory created: $VDIR"
else
    echo "Directory already exists: $VDIR"
    exit 1
fi

ls -l /var/www/

sudo a2ensite ${FQDN}
sudo systemctl restart apache2

echo "New vhost ${FQDN} created successfully!"
echo "Apache2 restarted ..... ok!"

