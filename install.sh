#!/bin/bash
# hon Code 2023 (Y18-M12-Y2023 23:59:59++ **12:24** (UTC/GMT +2))
# Apache2 + PHP + MySQL + phpMyAdmin easy setup for CentOS7
echo "[ INFO ] Starting installation of Apache2..."
yum -y install httpd
echo "[ INFO ] Apache2 installation finished."
echo "[ INFO ] Starting Apache2"
systemctl start httpd
echo "[ INFO ] Enabling Apache2"
systemctl enable httpd
echo "[ INFO ] Opening firewall ports"
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
echo "[ INFO ] You can test the setup of the apache2 server by visiting:"
ipaddr=$(hostname -I)
echo "http://$ipaddr"
echo ""
echo "[ INFO ] Starting installation of MySQL"
yum -y install http://repo.mysql.com/yum/mysql-5.5-community/el/7/x86_64/mysql-community-release-el7-5.noarch.rpm
yum -y install mysql-community-server
echo "[ INFO ] MySQL Installation finished"
echo "[ INFO ] Starting MySQL"
service mysqld start
echo "[ INFO ] Enabling MySQL"
systemctl enable mysqld
echo "[ INFO ] Setting-up MySQL"
{ 
	echo ""
	echo "y"
	echo "root"
	echo "root"
	echo "y"
	echo "n"
	echo "n"
	echo "y"
} | mysql_secure_installation
echo "[ INFO ] Restarting MySQL"
systemctl restart mysqld
echo ""
echo "[ INFO ] Sarting PHP Installation..."
rpm -Uvh https://mirror.webtatic.com/yum/el7/epel-release.rpm
rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
yum -y install php55w php55w-opcache
echo "[ INFO ] Creating a test PHP file."
echo "<?php
phpinfo();
?>" > /var/www/html/test.php
echo "[ INFO ] Restarting apache2 to enable PHP"
systemctl restart httpd
echo ""
echo "[ INFO ] Starting phpMyAdmin installation..."
yum -y install phpmyadmin
echo "[ INFO ] Configuring phpMyAdmin..."
sed -i '/AddDefaultCharset UTF-8/a Require all granted' /etc/httpd/conf.d/phpMyAdmin.conf
echo "[ INFO ] Restarting apache2 to apply phpMyAdmin Configuration..."
systemctl restart httpd
echo ""
echo ""
#The ip may have changed
ipaddr=$(hostname -I)
echo -e "\e[36mThe install was successfull\n=========================================="
echo -e "\e[95mWebsite link:\e[36m"
echo -e "\e[93mhttp://$ipaddr\e[36m"
echo -e "\e[95mphpMyAdmin link:\e[36m"
echo -n -e "\e[93mhttp://"
printf $ipaddr
echo -e "/phpmyadmin\e[36m"
echo -e "\e[95mphpMyAdmin username:\e[36m"
echo -e "\e[93mroot\e[36m"
echo -e "\e[95mphpMyAdmin password:\e[36m"
echo -e "\e[93mroot\e[36m"
echo -e "\e[95mThe apache files dir is:\e[36m"
echo -e "\e[93m/var/www/html\e[36m"
echo "=========================================="
echo -e "\e[0m"
