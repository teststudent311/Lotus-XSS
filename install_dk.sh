#!/bin/bash

echo "Please enter a password for the MySQL user 'lotusxssuser' (press Enter for default '1234'):"
read -s MYSQL_USER_PASSWORD
MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD:-1234}
echo ""

echo "Enter the path to the SSL certificate (press Enter to create self-signed certificates):"
read SSL_CERT_PATH
echo "Enter the path to the SSL certificate key (press Enter to use default self-signed key):"
read SSL_KEY_PATH

if [[ ! -f "$SSL_CERT_PATH" ]]; then
    echo "SSL certificate not found. Creating a self-signed certificate."
    sudo mkdir -p /etc/ssl/lotusxss
    cd /etc/ssl/lotusxss
    sudo openssl genrsa -out localhost.key 2048
    sudo openssl req -new -x509 -key localhost.key -out localhost.crt -days 3650 -subj "/CN=localhost"
    SSL_CERT_PATH="/etc/ssl/lotusxss/localhost.crt"
    SSL_KEY_PATH="/etc/ssl/lotusxss/localhost.key"
else
    if [[ ! -f "$SSL_KEY_PATH" ]]; then
        echo "SSL certificate key not found. Exiting."
        exit 1
    fi
fi

sudo apt-get update -y && sudo apt-get dist-upgrade -y
sudo apt-get install python3 docker.io docker-compose php php-mysql mariadb-server curl php-curl php-fpm -y

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

sudo sed -i 's/dbUser=lotusxss/dbUser=lotusxssuser/g' /var/www/html/.env
sudo sed -i "s/dbPassword=changeme/dbPassword=$MYSQL_USER_PASSWORD/g" /var/www/html/.env
sudo sed -i 's/dbName=database/dbName=lotusxss/g' /var/www/html/.env

sudo sed -i "s|prCertFile=/home/lotusxss/domains/example.com/ssl.cert|prCertFile=$SSL_CERT_PATH|g" /var/www/html/.env
sudo sed -i "s|prKeyFile=/home/lotusxss/domains/example.com/ssl.key|prKeyFile=$SSL_KEY_PATH|g" /var/www/html/.env

echo ""
echo "Do you want to configure SMTP settings? (yes/no):"
read CONFIGURE_SMTP

if [[ $CONFIGURE_SMTP == "yes" || $CONFIGURE_SMTP == "Yes" ]]; then
    echo "Enter SMTP host (press Enter for default 'smtp.example.com'):"
    read SMTP_HOST
    SMTP_HOST=${SMTP_HOST:-smtp.example.com}

    echo "Enter SMTP user (press Enter for default 'usernamegoeshere'):"
    read SMTP_USER
    SMTP_USER=${SMTP_USER:-usernamegoeshere}

    echo "Enter SMTP password (press Enter for default 'passwordgoeshere'):"
    read -s SMTP_PASSWORD
    SMTP_PASSWORD=${SMTP_PASSWORD:-passwordgoeshere}
    echo ""

    echo "Enter SMTP 'from' address (press Enter for default 'LotusXSS@example.com'):"
    read SMTP_FROM
    SMTP_FROM=${SMTP_FROM:-LotusXSS@example.com}

    sudo sed -i "s|host smtp.example.com|host $SMTP_HOST|g" /var/www/html/msmtprc
    sudo sed -i "s|user usernamegoeshere|user $SMTP_USER|g" /var/www/html/msmtprc
    sudo sed -i "s|password passwordgoeshere|password $SMTP_PASSWORD|g" /var/www/html/msmtprc
    sudo sed -i "s|from LotusXSS@example.com|from $SMTP_FROM|g" /var/www/html/msmtprc
else
    sudo sed -i 's/useMailAlerts=true/useMailAlerts=false/g' /var/www/html/.env
fi

sudo docker-compose build && sudo docker-compose up -d

echo ""
echo "All done!"
