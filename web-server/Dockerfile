FROM dokken/ubuntu-22.04

ARG CACTI_VERSION

# install modules
RUN apt update
RUN apt install -y git
RUN apt install -y apache2 rrdtool snmp snmpd openssh-server
RUN apt install -y php8.1 php-mysql php8.1-snmp php8.1-xml php8.1-mbstring php8.1-gd php8.1-gmp php8.1-zip php8.1-ldap php8.1-intl

# PHP config
RUN sed -i 's/memory_limit = 128M/memory_limit = 400M/g' /etc/php/8.1/apache2/php.ini
RUN sed -i 's/max_execution_time = 30/max_execution_time = 60/g' /etc/php/8.1/apache2/php.ini
RUN sed -i 's/;date.timezone =/date.timezone = America\/Los_Angeles/g' /etc/php/8.1/apache2/php.ini
RUN sed -i 's/;date.timezone =/date.timezone = America\/Los_Angeles/g' /etc/php/8.1/cli/php.ini

# install spine
RUN git clone -b release/$CACTI_VERSION https://github.com/Cacti/spine.git
RUN apt install -y build-essential autoconf automake dos2unix gzip help2man m4 make wget libtool libsnmp-dev libmariadb-dev 
RUN (cd spine; ./bootstrap; ./configure; make; make install)
RUN sed 's/^DB_Host.*/DB_Host       mysql-server/g' /usr/local/spine/etc/spine.conf.dist > /usr/local/spine/etc/spine.conf

# set crontab
RUN (crontab -l ; echo "*/5 * * * * php /var/www/html/cacti/poller.php >/dev/null 2>&1") | crontab

# copy scripts
COPY ./web-server/docker-entrypoint.sh .
COPY ./web-server/docker-init-cacti.sh .

# generate ssh key
RUN ssh-keygen -b 4096 -t rsa -f /root/.ssh/id_rsa -q -N ""

#####################################################
# for monitoring local cacti server

# create cacti user
RUN useradd -m -p $(perl -e 'print crypt($ARGV[0], "password")' 'cacti') cacti

# ssh connection for cacti
RUN mkdir -p /home/cacti/.ssh
RUN cat /root/.ssh/id_rsa.pub >> /home/cacti/.ssh/authorized_keys
RUN chown -R cacti.cacti /home/cacti/.ssh
RUN chmod 700 /home/cacti/.ssh
RUN chmod 600 /home/cacti/.ssh/authorized_keys

# apache server status
ARG APACHE2_LOCAL_CONFIG=/etc/apache2/sites-enabled/local.conf
RUN touch $APACHE2_LOCAL_CONFIG
RUN echo "ExtendedStatus On" >> $APACHE2_LOCAL_CONFIG
RUN echo "<Location /server-status>" >> $APACHE2_LOCAL_CONFIG
RUN echo "    SetHandler server-status" >> $APACHE2_LOCAL_CONFIG
RUN echo "    Require local" >> $APACHE2_LOCAL_CONFIG
RUN echo "</Location>" >> $APACHE2_LOCAL_CONFIG
#####################################################

# expose port
EXPOSE 80

# entrypoint
ENTRYPOINT ["/bin/bash", "docker-entrypoint.sh"]
