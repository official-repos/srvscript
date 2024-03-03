#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" -ne "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

# Prompt for username
read -p "Enter username: " username

# Check if the user already exists
if id "$username" &>/dev/null; then
  echo "User $username already exists."
  exit 1
fi

# Create the user
useradd -m "$username"

# Prompt for password
read -sp "Enter password: " password
echo

# Set the password
echo "$username:$password" | chpasswd

echo "User $username created and password assigned."
echo "Write this pwd into secure file: $password"
