#!/bin/bash

#clear

if [ "$EUID" -ne 0 ]; then
    echo "error:: This script requires sudo privileges."
    exit 1
fi

if [ -n "$SUDO_USER" ]; then
    echo "This script is running with sudo by user: $SUDO_USER"
else
    echo "error:: This script is not running with sudo."
    exit 1
fi

# Check if the root password for MySQL is empty
mysql_status=$(mysql -uroot -e "SELECT 'MySQL is running with an empty root password.' AS result;" 2>&1)

if [[ $mysql_status == *"Access denied for user 'root'@'localhost'"* ]]; then
    echo "error:: MySQL root password is not empty."
    exit 1
elif [[ $mysql_status == *"MySQL is running with an empty root password."* ]]; then
    echo "Ok, MySQL root password is empty."
else
    echo "error:: An error occurred while checking MySQL root password status."
    exit 1
fi

echo "Since mysql root password is empty, let set the password now."

echo "Please enter new password for root (mysql):"
read NEWPWD

# Check if input is empty
if [ -z "$NEWPWD" ]; then
    echo "No password entered. Exiting."
    exit 1
fi

mysql -u root << EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$NEWPWD';
FLUSH PRIVILEGES;
EOF
if [ $? -eq 0 ]; then
    echo "MySQL root password changed successfully."
else
    echo "Failed to change MySQL root password."
    exit 1
fi

# set /root/.my.cnf
echo "[client]
user=root
password=${NEWPWD}
" > /root/.my.cnf

# Your script logic here
echo "Your mysql new password is: $NEWPWD"


