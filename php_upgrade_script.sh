#!/bin/bash

sudo add-apt-repository ppa:ondrej/php -y
sudo apt-get update -y
sudo apt-get install php$1 -y
sudo apt-get install php$1-cli php$1-common php$1-json php$1-opcache php$1-mysql php$1-mbstring  php$1-zip php$1-fpm php$1-intl php$1-simplexml -y
sudo apt install libapache2-mod-php$1 libapache2-mod-php -y
current_version=$(php -v |grep PHP | head -n 1 | cut -d" " -f2|cut -d"." -f1-2)
sudo a2dismod php$current_version
sudo a2enmod php$1
sudo service apache2 restart
sudo update-alternatives --set php /usr/bin/php$1
sudo update-alternatives --set phar /usr/bin/phar$1
sudo update-alternatives --set phar.phar /usr/bin/phar.phar$1
sudo update-alternatives --set phpize /usr/bin/phpize$1
sudo update-alternatives --set php-config /usr/bin/php-config$1
