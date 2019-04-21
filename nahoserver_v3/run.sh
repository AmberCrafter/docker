#!/bin/sh
service ssh start
service apache2 start
chown -R mysql:mysql /var/lib/mysql /var/run/mysqld
service mysql start
tail -f /dev/null