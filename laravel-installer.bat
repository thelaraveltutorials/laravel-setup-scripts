@echo off

echo ########################################################
echo #                                                      #
echo #   Welcome to laravel Apllication Installer           #
echo #        Deleveoped by Puneet Choudhary                #
echo #                                                      #
echo ########################################################

title Laravel Project Installer

set xamppAddress=D:\xampp

set /p projectName="Enter project name: "
set /p laravelVersion="Enter laravel version: "
set /p projectURL="Enter project URL: "

cd /D %xamppAddress%\htdocs
echo --Installing laravel on %xamppAddress%\htdocs
call composer create-project laravel/laravel=%laravelVersion% %projectName%

echo --Updating hosts file
echo 127.0.0.1 %projectURL% >>C:\Windows\System32\drivers\etc\hosts

echo --Updating VirtualHost
echo ^<VirtualHost ^*:80^> >>D:\xampp\apache\conf\extra\httpd-vhosts.conf
echo DocumentRoot "D:/xampp/htdocs/%projectName%/public" >>D:\xampp\apache\conf\extra\httpd-vhosts.conf
echo ServerName %projectURL% >>D:\xampp\apache\conf\extra\httpd-vhosts.conf
echo ^</VirtualHost^> >>D:\xampp\apache\conf\extra\httpd-vhosts.conf
cd /D C:\Users\DexHex\Desktop

echo --Restarting Apache Server
call %xamppAddress%\apache\bin\httpd.exe -k restart

echo Enjoy
echo 	-Made with Love
