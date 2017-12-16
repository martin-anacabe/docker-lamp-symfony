FROM phusion/baseimage:0.9.22
MAINTAINER Martín Anacabe <anacabe.martin@gmail.com>

ENV DEBIAN_FRONTEND=noninteractive \
    LETSENCRYPT_HOME=/etc/letsencrypt \
    DOMAINS="" \
    WEBMASTER_MAIL="" \
    DOCKER_HOME=/home/docker \
    DOCKER_UID=1000

# Manually set the apache environment variables in order to get apache to work immediately.
RUN echo $WEBMASTER_MAIL > /etc/container_environment/WEBMASTER_MAIL && \
    echo $DOMAINS > /etc/container_environment/DOMAINS && \
    echo $LETSENCRYPT_HOME > /etc/container_environment/LETSENCRYPT_HOME && \
    echo $DOCKER_HOME > /etc/container_environment/DOCKER_HOME && \
    echo $DOCKER_UID > /etc/container_environment/DOCKER_UID

CMD ["/sbin/my_init"]

# Set the entry directory
WORKDIR /var/www/html

# Expose the ports
EXPOSE 80 443

# Add sudo and aptitude
RUN apt-get update && apt-get install -y sudo aptitude && aptitude safe-upgrade -y

# Add utils
RUN aptitude install -y \
    acl \   
    curl \
    git \
    p7zip-full \
    software-properties-common \
    sqlite \
    vim \
    wget

# Add apache2 and lets encrypt for apache
RUN aptitude install -y apache2 python-letsencrypt-apache

# Add image configuration and scripts
ADD config/mods-available/proxy_html.conf /etc/apache2/mods-available/
ADD config/conf-available/security.conf /etc/apache2/conf-available/
RUN echo "ServerName localhost" >> /etc/apache2/conf-enabled/hostname.conf && \
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf && \
    a2enmod ssl headers proxy proxy_http proxy_html xml2enc rewrite usertrack remoteip && \
    a2dissite 000-default default-ssl && \
    mkdir -p /var/lock/apache2 && \
    mkdir -p /var/run/apache2

# Configure runit
RUN mkdir -p /etc/service/apache
ADD config/scripts/run_apache.sh /etc/service/apache/run
ADD config/scripts/init_letsencrypt.sh /etc/my_init.d/
ADD config/scripts/init_docker_user.sh /etc/my_init.d/
ADD config/scripts/run_letsencrypt.sh /bin/run_letsencrypt.sh
RUN chmod +x /bin/*.sh && chmod +x /etc/my_init.d/*.sh && chmod +x /etc/service/apache/*

# Add php
ENV PHP_VERSION 5.6
RUN add-apt-repository ppa:ondrej/php && aptitude update
RUN aptitude install -y \
        libapache2-mod-php$PHP_VERSION \
        php$PHP_VERSION \
        #php$PHP_VERSION-apcu \
        php$PHP_VERSION-curl \
        php$PHP_VERSION-gd \
        php$PHP_VERSION-intl \
        php$PHP_VERSION-mbstring \
        php$PHP_VERSION-mcrypt \
        php$PHP_VERSION-mysqlnd \
        php$PHP_VERSION-sqlite3 \
        php$PHP_VERSION-xml
        
# Config php
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php/$PHP_VERSION/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/php/$PHP_VERSION/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/php/$PHP_VERSION/cli/php.ini

# Download composer, phpunit and nvm
RUN wget -q -O /usr/local/bin/composer https://getcomposer.org/composer.phar && chmod +x /usr/local/bin/composer && \
    wget -q -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-5.7.phar && chmod +x /usr/local/bin/phpunit && \
    wget -q -O /bin/install-nvm.sh https://raw.githubusercontent.com/creationix/nvm/master/install.sh && chmod +x /bin/install-nvm.sh

ADD scripts/*.sh /bin/
RUN chmod +x /bin/*.sh

## Clean image
#RUN rm -rf /var/lib/apt/lists/**

RUN mkdir -p /etc/apache2/ssl

VOLUME [ "$LETSENCRYPT_HOME", "/etc/apache2/ssl", "/var/log/apache2" ]