#!/bin/bash
echo -e "\n[+] Cloning AdminLTE Generator Package"
git clone https://github.com/InfyOmLabs/adminlte-generator.git > /dev/null
cd adminlte-generator
echo -e "\n[+] Installing Libraries"

composer install 

echo -e "\n[+] Installing GUI Generator"
cp composer.json composer-backup.json
sed '20i\\t"infyomlabs/generator-builder": "dev-master",' composer-backup.json > composer.json
composer update
rm composer-backup.json
echo -e "\n[+] Updating config/app.php"

cp config/app.php /tmp/app.php
sed '184i\\t\\\InfyOm\\GeneratorBuilder\\GeneratorBuilderServiceProvider::class,' /tmp/app.php > config/app.php
rm /tmp/app.php

echo -e "\n[+] Publishing Vendor"
php artisan vendor:publish --all 
echo -e "\n[+] Generating views for GUI generator"
php artisan infyom.publish:generator-builder > /dev/null
cp .env.example .env
php artisan key:generate

firefox -new-tab "http://127.0.0.1:8000/generator_builder"
php artisan serv
echo -e "\n[+] made with love <3"
echo -e "\n[+] Buy me a coffee :)"

