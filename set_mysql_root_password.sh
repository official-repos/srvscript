#!/bin/bash

clear

if [ "$EUID" -ne 0 ]; then
    echo "This script requires sudo privileges."
    exit 1
fi

if [ -n "$SUDO_USER" ]; then
    echo "This script is running with sudo by user: $SUDO_USER"
else
    echo "This script is not running with sudo."
fi

# Check if the root password for MySQL is empty
mysql_status=$(mysql -uroot -e "SELECT 'MySQL is running with an empty root password.' AS result;" 2>&1)

if [[ $mysql_status == *"Access denied for user 'root'@'localhost'"* ]]; then
    echo "MySQL root password is not empty."
elif [[ $mysql_status == *"MySQL is running with an empty root password."* ]]; then
    echo "MySQL root password is empty."
else
    echo "An error occurred while checking MySQL root password status."
fi

echo "Since mysql root password is empty, let set the password now."

echo "Please enter new password:"
read NEWPWD

# Check if input is empty
if [ -z "$NEWPWD" ]; then
    echo "No password entered. Exiting."
    exit 1
fi

mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$NEWPWD';
EOF
if [ $? -eq 0 ]; then
    echo "MySQL root password changed successfully."
else
    echo "Failed to change MySQL root password."
fi

# Your script logic here
echo "Your input is: $NEWPWD"


