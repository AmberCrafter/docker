#!/bin/sh
service apache2 start
service mysql start
service ssh start
tail -f /dev/null


# docker cp ./run.sh nahoserver:/root/run.sh