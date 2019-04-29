From ubuntu:latest      
# 18.04.2 LTS
# Change password at first and commit to this image.
# RUN apt-get update
# RUN apt-get install -y net-tools 
# RUN apt-get install -y vim
# RUN apt-get install -y openssh-server
# RUN apt-get install -y apache2
# RUN ln -s /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/cgid.load
# RUN ln -s /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/cgid.conf
# RUN ln -s /usr/lib/cgi-bin /var/www/cgi-bin
# RUN service apache2 restart
# RUN apt-get install -y mysql-server    # localhost without password
#=================================================================================================#
# Install some services and modules.  [ DEBIAN_FRONTEND=noninteractive ]
RUN DEBIAN_FRONTEND=noninteractive apt-get update && DEBIAN_FRONTEND=noninteractive apt-get \
  install -y net-tools vim openssh-server apache2 php7.0 python3-pip mysql-server
#=================================================================================================#
# Setting environment for apache2 and bash
RUN pip3 install pymysql \
  && ln -s /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/cgid.load \
  && ln -s /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/cgid.conf \
  && ln -s /usr/lib/cgi-bin /var/www/cgi-bin \
#  && mkdir /var/run/sshd \
  && echo 'root:ideasky' | chpasswd 
#  && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Setting enviroment for mysql
# ENV MYSQL_ALLOW_EMPTY_PASSWORD yes

COPY ./sshd_config /etc/ssh/sshd_config
COPY ./mysql.sql /root/mysql.sql
COPY ./run.sh /root/run.sh

#=================================================================================================#

# VOLUME "/var/www/html/"
# VOLUME "/var/www/cgi-bin/"
# VOLUME "/var/log/"
# 
# EXPOSE 22		# 此port權限由docker server設定為:only allow at 140.115.*.*。
# EXPOSE 80		# 此port不做設限。
# EXPOSE 3306 	# 此port權限由docker server設定為:only allow at 140.115.*.*。

CMD ["/bin/bash","-c","/root/run.sh"]

# docker build -t nahoserver_v3.1.0 .
# docker run -it -p 8000:80 -p 40000:22 --name nahoserver nahoserver_v3.1.0
# docker cp ./run.sh nahoserver:/root/run.sh
# docker exec -it nahoserver /root/run.sh