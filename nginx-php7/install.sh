#!/bin/bash
cat << 'EOT' > /etc/yum.repos.d/nginx.repo
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/$basearch/
gpgcheck=0
enabled=1
EOT

yum install epel-release
yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm

yum -y update
yum -y install --enablerepo=remi-php70 php-fpm \
    php-cli \
	php-dbg \
	php-mbstring \
	php-intl \
	php-opcache \
	php-pecl-apcu \
	php-mcrypt \
	php-process \
	php-pecl-igbinary \
	php-gmp \
	php-xml \
	php-pdo \
	php-mysqlnd \
	php-bcmath \
	php-mongodb \
	php-geoip

yum -y install nginx

yum clean all

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === 'bf16ac69bd8b807bc6e4499b28968ee87456e29a3894767b60c2d4dafa3d10d045ffef2aeb2e78827fa5f024fbe93ca2') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
mv composer.phar /usr/local/bin/composer