# srvscript
Bash automation to make easy installation of LAMP stack (Linux Apache Mysql and Phpmyadmin).
Tested on following Ubuntu server version:
- Ubuntu server 20.04LTS (tested at 20240702)
- Ubuntu server 22.04LTS (tested long time ago)
- Ubuntu server 24.04LTS (tested at 20240704)
- Ubuntu server 14.04LTS (tested at 20240712)

# How-To
cd /tmp \
git clone https://github.com/official-repos/srvscript \
cd srvscript \
sudo cp ./files/sudoers.d/97-localadmin /etc/sudoers.d/ \
sudo ./ub22_install_lamp.sh \
sudo ./create_admin_user.sh \
sudo ./set_mysql_root_password.sh \
sudo ./create_vhost.sh \
sudo nano /etc/crontab \
sudo reboot 



