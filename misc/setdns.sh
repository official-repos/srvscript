#!/bin/bash
sudo apt install resolvconf 
sudo systemctl enable --now resolvconf.service

sudo nano /etc/resolvconf/resolv.conf.d/head
# Use these nameservers
# nameserver 8.8.8.8 
# nameserver 8.8.4.4

sudo resolvconf -u

