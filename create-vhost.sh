#!/bin/bash
git pull

echo -n "Enter fqdn: "
read FQDN
echo ${FQDN}

#sudo cp ./files/vhost-template.conf /etc/apache2/sites-available/${FQDN}
