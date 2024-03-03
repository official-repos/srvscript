#!/bin/bash

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
