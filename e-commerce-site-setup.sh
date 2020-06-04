#!/bin/bash

read -s -p "Enter desired MySQL password: "  my_mysql_password
echo ""
read -s -p "Confirm password: "  my_mysql_password2
if [ "$my_mysql_password" == "$my_mysql_password2" ]; then
    echo -e "\nPassword matched!"
    read -p "Enable debug mode [yes/no]: "  debugMode
    if [ "$debugMode" == "no" ]; then
        echo -e "\n[+] Updating Package List..."
        sudo apt-get update > TheLaravelTutorial.log

        echo -e "\n[+] Installing Apache Server..."
        sudo apt-get install -y apache2 > TheLaravelTutorial.log
        echo -e "\n[+] Installed Apache Server!"

        echo -e "\n[+] Installing MySQL Server..."
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $my_mysql_password"
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $my_mysql_password"
        sudo apt-get install -y  mysql-server >> TheLaravelTutorial.log
        echo -e "\n[+] Installed MySQL Server!"

        echo -e "\n[+] Installing PHP & PHP Libraries.."
        sudo apt-get install -y  php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-token-stream php-xml php-json php7.2-common php7.2-bcmath php7.2-intl libapache2-mod-php >> TheLaravelTutorial.log
        sudo apt-get install -y  curl php-cli git >> TheLaravelTutorial.log
        echo -e "\n[+] Installed PHP & PHP Libraries!"

        echo -e "\n[+] Installing Composer..."
        sudo sudo apt-get install -y composer
        echo -e "\n[+] Installed Composer!"

        echo -e "\n[+] Restarting Apache Server..."
        sudo service apache2 restart >> TheLaravelTutorial.log

        echo -e "\n[+] Installing PHPMyAdmin..."
        MYSQL_ROOT_PASS="$my_mysql_password"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-user string root"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS"
        apt-get -y install phpmyadmin >> TheLaravelTutorial.log
        echo -e "\n[+] Installed PHPMyAdmin!"

        read -p "Do you want to install Visual Studio Code? [yes/no]: "  vscode
        if [ "$vscode" == "yes" ]; then
            echo -e "\n[+] Installing PHPMyAdmin..."
            cd ~/Downloads
            wget https://az764295.vo.msecnd.net/stable/7c66f58312b48ed8ca4e387ebd9ffe9605332caa/code_1.31.0-1549443364_amd64.deb >> TheLaravelTutorial.log
            sudo dpkg -i code_1.31.0-1549443364_amd64.deb  >> TheLaravelTutorial.log
            echo -e "\n[+] Installed Visual Studio Code!"
        fi
        
        echo -e "\nEnjoy"
        echo -e "\n    The Laravel Tutorial Team"
    else
        echo -e "\n[+] Updating Package List..."
        sudo apt-get update

        echo -e "\n[+] Installing Apache Server..."
        sudo apt-get install -y apache2 
        echo -e "\n[+] Installed Apache Server!"

        echo -e "\n[+] Installing MySQL Server..."
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $my_mysql_password"
        sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $my_mysql_password"
        sudo apt-get install -y  mysql-server
        echo -e "\n[+] Installed MySQL Server!"

        echo -e "\n[+] Installing PHP & PHP Libraries.."
        sudo apt-get install -y  php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-token-stream php-xml php-json php7.2-common php7.2-bcmath libapache2-mod-php
        sudo apt-get install -y  curl php-cli git
        echo -e "\n[+] Installed PHP & PHP Libraries!"

        echo -e "\n[+] Installing Composer..."
        sudo sudo apt-get install -y composer
        echo -e "\n[+] Installed Composer!"

        echo -e "\n[+] Restarting Apache Server..."
        sudo service apache2 restart

        echo -e "\n[+] Installing PHPMyAdmin..."
        MYSQL_ROOT_PASS="$my_mysql_password"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-user string root"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS"
        debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS"
        apt-get -y install phpmyadmin
        echo -e "\n[+] Installed PHPMyAdmin!"
        echo -e "\n[+] Patching PHPMyAdmin count error!"
        sudo sed -i "s/|\s*\((count(\$analyzed_sql_results\['select_expr'\]\)/| (\1)/g" /usr/share/phpmyadmin/libraries/sql.lib.php
        sudo service apache2 restart

        read -p "Do you want to install Visual Studio Code? [yes/no]: "  vscode
        if [ "$vscode" == "yes" ]; then
            echo -e "\n[+] Installing PHPMyAdmin..."
            cd ~/Downloads
            wget https://az764295.vo.msecnd.net/stable/7c66f58312b48ed8ca4e387ebd9ffe9605332caa/code_1.31.0-1549443364_amd64.deb
            sudo dpkg -i code_1.31.0-1549443364_amd64.deb 
            echo -e "\n[+] Installed Visual Studio Code!"
        fi
        
        echo -e "\nEnjoy"
        
    fi
fi
