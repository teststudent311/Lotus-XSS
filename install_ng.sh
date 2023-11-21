#!/bin/bash

echo "Please enter a password for the MySQL user 'lotusxssuser' (press Enter for default '1234'):"
read -s MYSQL_USER_PASSWORD
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-1234}
echo ""

echo "Enter the database host name (press Enter for default 'localhost'):"
read DB_HOST
DB_HOST=${DB_HOST:-localhost}

echo "Enter the server name (press Enter for default 'localhost'):"
read SERVER_NAME
SERVER_NAME=${SERVER_NAME:-localhost}

echo "Enter the path to the SSL certificate (press Enter to create self-signed certificates):"
read SSL_CERT_PATH
echo "Enter the path to the SSL certificate key (press Enter to use default self-signed key):"
read SSL_KEY_PATH

if [[ ! -f "$SSL_CERT_PATH" ]]; then
    echo "SSL certificate not found. Creating a self-signed certificate."
    sudo mkdir -p /etc/ssl/nginx
    cd /etc/ssl/nginx
    sudo openssl genrsa -out localhost.key 2048
    sudo openssl req -new -x509 -key localhost.key -out localhost.crt -days 3650 -subj "/CN=localhost"
    SSL_CERT_PATH="/etc/ssl/nginx/localhost.crt"
    SSL_KEY_PATH="/etc/ssl/nginx/localhost.key"
else
    if [[ ! -f "$SSL_KEY_PATH" ]]; then
        echo "SSL certificate key not found. Exiting."
        exit 1
    fi
fi

sudo apt-get update -y && sudo apt-get dist-upgrade -y
sudo apt-get install nginx php php-mysql mariadb-server curl php-curl php-fpm -y

PHP_VERSION=$(php -v | head -n 1 | cut -d ' ' -f 2 | cut -d '.' -f 1,2)
PHP_FPM_VERSION="php${PHP_VERSION}-fpm"

sudo systemctl enable mariadb
sudo systemctl start mariadb

sudo systemctl enable nginx
sudo systemctl start nginx

sudo systemctl enable nginx.service
sudo systemctl start nginx.service

sudo systemctl enable $PHP_FPM_VERSION
sudo systemctl start $PHP_FPM_VERSION

sudo systemctl enable $PHP_FPM_VERSION.service
sudo systemctl start $PHP_FPM_VERSION.service

git clone https://github.com/teststudent311/LotusXSS.git /tmp/LotusXSS
cd /tmp/LotusXSS
sudo mv .env.example 1.env.example
sudo mv .htaccess 2.htaccess

sudo cp -r /tmp/LotusXSS/* /var/www/html/
rm -rf /tmp/LotusXSS

cd /var/www/html/
sudo sed -i "s|fastcgi_pass unix:/run/php/php8.2-fpm.sock;|fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;|g" nginx-rewrite.conf
sudo sed -i "s|ssl_certificate .*/.*;|ssl_certificate $SSL_CERT_PATH;|g" nginx-rewrite.conf
sudo sed -i "s|ssl_certificate_key .*/.*;|ssl_certificate_key $SSL_KEY_PATH;|g" nginx-rewrite.conf
sudo sed -i "s/server_name 'domain.tld';/server_name '$SERVER_NAME';/g" nginx-rewrite.conf
sudo sed -i "s/index index.php index.html index.htm index.nginx-debian.html;\n\n    client_max_body_size 150m;\n\n    autoindex off;\n\n    server_name 'domain.tld';/index index.php index.html index.htm index.nginx-debian.html;\n\n    client_max_body_size 150m;\n\n    autoindex off;\n\n    server_name '$SERVER_NAME';/g" nginx-rewrite.conf

sudo mv 1.env.example .env
sudo mv 2.htaccess .htaccess

sudo mv nginx-rewrite.conf /etc/nginx/sites-enabled/default

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

sudo chmod 777 /var/www/html/assets/img

sudo systemctl restart nginx
sudo systemctl restart nginx.service
sudo systemctl restart $PHP_FPM_VERSION
sudo systemctl restart $PHP_FPM_VERSION.service

echo ""
echo "All done!"
