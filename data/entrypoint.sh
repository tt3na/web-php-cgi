#!/bin/bash

sed -i 's/User apache/User pi/g' /etc/httpd/conf/httpd.conf
sed -i 's/Group apache/Group pi/g' /etc/httpd/conf/httpd.conf

cat << FIN >> /etc/httpd/conf/httpd.conf

<Directory "/home/pi/www">
        Options +Indexes +FollowSymLinks +ExecCGI
	AddHandler cgi-script .cgi .ajax .py
        AllowOverride All
        Require all granted
</Directory>

NameVirtualHost *:80
<VirtualHost *:80>
    DocumentRoot /home/pi/www
</VirtualHost>
FIN

cat << FIN >> /etc/httpd/conf.modules.d/00-mpm.conf
ScriptSock /var/run/httpd/cgid.sock
FIN

mkdir /var/run/php-fpm

chown pi:pi /var/run/httpd
chown pi:pi -R /var/run/php-fpm/
chown pi:pi -R /var/lib/php/session

/usr/sbin/php-fpm &

exec /usr/sbin/httpd -DFOREGROUND

exit 0
