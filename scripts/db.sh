#!/bin/bash

# Create the directory if it doesn't exist
mkdir -p /vagrant/passwords

# Define MySQL root password
MYSQL_ROOT_PASSWORD=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9')
MYSQL_NEW_USER_PASSWORD=$(openssl rand -base64 16 | tr -dc 'a-zA-Z0-9')

# Save the passwords to text files
echo "$MYSQL_ROOT_PASSWORD" > /vagrant/passwords/db_root.txt
echo "$MYSQL_NEW_USER_PASSWORD" > /vagrant/passwords/db_webadmin.txt

# Install and start MySQL server
apt install mysql-server -y
systemctl start mysql.service
systemctl enable mysql.service

# Switch the authentication method to 'mysql_native_password' for the root user
mysql <<EOF
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Finish configuration
mysql -u root -p$MYSQL_ROOT_PASSWORD <<EOF
-- Remove anonymous users
DELETE FROM mysql.user WHERE User='';

-- Restrict root access to localhost only
UPDATE mysql.user SET Host='localhost' WHERE User='root' AND Host!='localhost';

-- Drop the test database if it exists
DROP DATABASE IF EXISTS test;

-- Create a new user with access from any host
CREATE USER 'webadmin'@'%' IDENTIFIED BY '$MYSQL_NEW_USER_PASSWORD';

-- Grant all privileges to the new user
GRANT ALL PRIVILEGES ON *.* TO 'webadmin'@'%' WITH GRANT OPTION;

-- Apply changes
FLUSH PRIVILEGES;
EOF

# Define MySQL configuration file path
MYSQL_CONFIG_FILE="/etc/mysql/mysql.conf.d/mysqld.cnf"

# Backup file
cp $MYSQL_CONFIG_FILE "$MYSQL_CONFIG_FILE.bak"

# Allow remote connections
sed -i 's/^bind-address\s*=.*/bind-address = 0.0.0.0/' $MYSQL_CONFIG_FILE

# Restart MySQL service to apply changes
systemctl restart mysql

# Allow MySQL traffic through firewall (port 3306)
ufw allow 3306/tcp

# Output completion message
echo "MySQL installation and configuration completed successfully."