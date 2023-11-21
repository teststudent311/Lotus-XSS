#!/bin/bash

echo "Please enter a password for the MySQL user 'lotusxssuser' (press Enter for default '1234'):"
read -s MYSQL_USER_PASSWORD
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-1234}
echo ""

echo "Enter the database host name (press Enter for default 'localhost'):"
read DB_HOST
DB_HOST=${DB_HOST:-localhost}

sudo apt-get update -y && sudo apt-get dist-upgrade -y
sudo apt-get install apache2 php php-mysql mariadb-server curl php-curl php-fpm -y

sudo systemctl enable mariadb
sudo systemctl start mariadb

git clone https://github.com/teststudent311/LotusXSS.git /tmp/LotusXSS
cd /tmp/LotusXSS
sudo mv .env.example 1.env.example
sudo mv .htaccess 2.htaccess

sudo cp -r /tmp/LotusXSS/* /var/www/html/
rm -rf /tmp/LotusXSS
cd /var/www/html/

sudo mv 1.env.example .env
sudo mv 2.htaccess .htaccess

sudo mysql -u root <<EOF
CREATE DATABASE lotusxss;
CREATE USER 'lotusxssuser'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD';
GRANT ALL PRIVILEGES ON lotusxss.* TO 'lotusxssuser'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo sed -i "s/dbHost=\"lotusxssdb\"/dbHost=\"$DB_HOST\"/g" /var/www/html/.env
sudo sed -i 's/dbUser=lotusxss/dbUser=lotusxssuser/g' /var/www/html/.env
sudo sed -i "s/dbPassword=changeme/dbPassword=$MYSQL_USER_PASSWORD/g" /var/www/html/.env
sudo sed -i 's/dbName=database/dbName=lotusxss/g' /var/www/html/.env

sudo sed -i '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf
sudo chmod 777 /var/www/html/assets/img

sudo a2enmod rewrite headers
sudo systemctl restart apache2

echo ""
echo "All done!"
