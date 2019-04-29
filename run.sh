#!/bin/sh
service ssh start
service apache2 start
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start

echo `service mysql status`
echo `MySQL設定導入中...`
mysql < /root/mysql.sql
echo `MySQL設定導入完畢`
service mysql restart

tail -f /dev/null