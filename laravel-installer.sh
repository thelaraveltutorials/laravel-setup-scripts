#!/bin/bash

echo "################################################################"
echo "#           Welcome to Laravel Application Installer           #" 
echo "#             Developed by TheLaravelTutorial Team             #" 
echo "#                     Version: 1.0 (Stable)                   #" 
echo "################################################################"


read -p 'Enter project name: ' projectName
read -p 'Enter laravel version: ' laravelVersion
read -p 'Enter project URL: ' projectURL


cd "/var/www/html"
echo "--Installing laravel on /var/www/html"

composer create-project laravel/laravel=$laravelVersion $projectName

sudo chown -R www-data:www-data /var/www/html/$projectName
sudo chmod -R 777 /var/www/html/$projectName

#Create configuration file for each host
echo "--Updating VirtualHost"
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/$projectName.conf

sudo echo "<VirtualHost *:80>" > /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tServerAdmin webmaster@$projectName" >> /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tServerName $projectURL" >> /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tServerAlias www.$projectURl" >> /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tDocumentRoot /var/www/html/$projectName/public" >> /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tErrorLog \${APACHE_LOG_DIR}/error.log" >> /etc/apache2/sites-available/$projectName.conf
sudo echo -e "\tCustomLog \${APACHE_LOG_DIR}/access.log combined" >> /etc/apache2/sites-available/$projectName.conf
sudo echo "</VirtualHost>" >> /etc/apache2/sites-available/$projectName.conf

sudo a2dissite 000-default.conf
sudo a2ensite $projectName.conf

echo "--Updating hosts file"
sudo echo "127.0.0.1 $projectURL" >> /etc/hosts



echo --Restarting Apache Server
sudo systemctl restart apache2

echo Enjoy
echo 	-Made with Love

