From ubuntu:latest      
# 18.04.2 LTS
# Change password at first and commit to this image.
# RUN apt-get update
# RUN apt-get install -y net-tools 
# RUN apt-get install -y vim
# RUN apt-get install -y openssh-server
# 
# RUN apt-get install -y apache2
# RUN ln -s /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/cgid.load
# RUN ln -s /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/cgid.conf
# RUN ln -s /usr/lib/cgi-bin /var/www/cgi-bin
# RUN service apache2 restart

# RUN apt-get install -y mysql-server    # localhost without password

RUN apt-get update && apt-get install -y net-tools vim openssh-server apache2 mysql-server
RUN ln -s /etc/apache2/mods-available/cgid.load /etc/apache2/mods-enabled/cgid.load \
  && ln -s /etc/apache2/mods-available/cgid.conf /etc/apache2/mods-enabled/cgid.conf \
  && ln -s /usr/lib/cgi-bin /var/www/cgi-bin \
#  && mkdir /var/run/sshd \
  && echo 'root:ideasky' | chpasswd 
#  && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile


ADD ./sshd_config /etc/ssh/sshd_config
ADD ./run.sh /root/run.sh

# VOLUME "/var/www/"
# VOLUME "/var/log/"
# VOLUME "/var/lib/mysql/"
# 
# EXPOSE 22
# EXPOSE 80
# EXPOSE 334

CMD ["/bin/bash","-c","/root/run.sh"]

# docker bulid -t nahoserver_v3.0.0 .
# docker run -it -p 8000:80 -p 40000:22 --name nahoserver nahoserver_v3.0.0
# docker cp ./run.sh nahoserver:/root/run.sh
# docker exec -it nahoserver /root/run.sh