#!/bin/bash

# Install apache
apt install apache2 -y

# Install php and mysql library
apt install php libapache2-mod-php php-mysql -y
systemctl restart apache2

# Install adminer
apt install adminer -y
a2enconf adminer
systemctl restart apache2

# Install NodeJS
curl -sL https://deb.nodesource.com/setup_23.x -o /tmp/nodesource_setup.sh
bash /tmp/nodesource_setup.sh
apt install nodejs -y