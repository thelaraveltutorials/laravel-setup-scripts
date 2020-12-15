echo "################################################################"
echo "#         Welcome to Laravel Environment Setup Script          #" 
echo "#             Developed by TheLaravelTutorial Team             #" 
echo "#                     Version: 1.02 (Stable)                   #" 
echo "################################################################"
echo ""
echo ""
read -p "Enter Your Name: "  name
echo ""
echo "Welcome $name!"
echo ""
read -s -p "Enter desired MySQL password: "  my_mysql_password
echo ""
read -s -p "Confirm password: "  my_mysql_password2

touch laravel-env-setup.log

if [ "$my_mysql_password" == "$my_mysql_password2" ]; then
	echo -e "\nPassword matched!"
	read -p "Enable debug mode [yes/no]: "  debugMode

	if [ "$debugMode" == "no" ]; then
	
		echo -e "\n[+] Updating Package List..."
	
		sudo apt update &> laravel-env-setup.log
		echo "[+] Installing Apache"
		sudo apt install apache2 -y &> laravel-env-setup.log

		echo "[+] Updating firewall rules"
		sudo ufw allow in "Apache"
		firefox http://localhost

		echo -e "\n[+] Installing MySQL Server..."
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $my_mysql_password"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $my_mysql_password"
		sudo apt-get install -y  mysql-server &> laravel-env-setup.log

		
		echo "[+] Installing mysql"
		sudo apt install mysql-server -y &> laravel-env-setup.log

		#sudo mysql_secure_installation


	        echo -e "\n[+] Installing PHP & PHP Libraries.."
		sudo apt install php libapache2-mod-php php-mysql -y
		sudo apt-get install -y  php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-token-stream php-xml php-json php7.2-common php7.2-bcmath libapache2-mod-php &> laravel-env-setup.log
		sudo apt-get install -y  curl php-cli git &> laravel-env-setup.log
		echo -e "\n[+] Installed PHP & PHP Libraries!"
		
		
		echo -e "\n[+] Installing Composer..."
		sudo sudo apt-get install -y composer &> laravel-env-setup.log
		echo -e "\n[+] Installed Composer!"

		echo -e "\n[+] Restarting Apache Server..."
		sudo service apache2 restart &> laravel-env-setup.log

		echo -e "\n[+] Installing PHPMyAdmin..."
		MYSQL_ROOT_PASS="$my_mysql_password"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-user string root"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS"
		sudo apt-get -y install phpmyadmin &> laravel-env-setup.log
		echo -e "\n[+] Installed PHPMyAdmin!"

		
	 else
	 			echo -e "\n[+] Updating Package List..."
	
		sudo apt update &> laravel-env-setup.log
		echo "[+] Installing Apache"
		sudo apt install apache2 -y 

		echo "[+] Updating firewall rules"
		sudo ufw allow in "Apache"
		firefox http://localhost

		echo -e "\n[+] Installing MySQL Server..."
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $my_mysql_password"
		sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $my_mysql_password"
		sudo apt-get install -y  mysql-server 

		
		echo "[+] Installing mysql"
		sudo apt install mysql-server -y 

		#sudo mysql_secure_installation 


	        echo -e "\n[+] Installing PHP & PHP Libraries.."
		sudo apt install php libapache2-mod-php php-mysql -y
		sudo apt-get install -y  php-pear php-fpm php-dev php-zip php-curl php-xmlrpc php-gd php-mysql php-mbstring php-token-stream php-xml php-json php7.4-common php7.4-bcmath libapache2-mod-php
		sudo apt-get install -y  curl php-cli git
		echo -e "\n[+] Installed PHP & PHP Libraries!"
		
		
		echo -e "\n[+] Installing Composer..."
		sudo sudo apt-get install -y composer
		echo -e "\n[+] Installed Composer!"

		echo -e "\n[+] Restarting Apache Server..."
		sudo service apache2 restart 

		echo -e "\n[+] Installing PHPMyAdmin..."
		MYSQL_ROOT_PASS="$my_mysql_password"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-user string root"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $MYSQL_ROOT_PASS"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $MYSQL_ROOT_PASS"
		sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $MYSQL_ROOT_PASS"
		sudo apt-get -y install phpmyadmin 
		echo -e "\n[+] Installed PHPMyAdmin!"
		
	fi
	echo -e "\nEnjoy"
        echo -e "\n    By Puneet"
fi
