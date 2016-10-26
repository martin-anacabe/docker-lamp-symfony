FROM ubuntu:trusty
MAINTAINER Martín Anacabe <anacabe.martin@gmail.com>

# Set LANG
RUN export LANG=C.UTF-8

# Add aptitude
RUN apt-get update && apt-get install -y aptitude

# Add image configuration and scripts
ADD scripts/*.sh /bin/

# Add supervisor
RUN aptitude install -y supervisor
RUN mkdir -p /var/log/supervisor

# Set permissions of scripts
RUN chmod 755 /bin/*.sh

# Add utils
RUN aptitude install -y \
    acl \
    curl \
    git \
    sqlite3 \
    wget

# Add add-apt-repository
RUN aptitude install -y software-properties-common && \
    add-apt-repository ppa:ondrej/php5-5.6  && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5267A6C && \
    aptitude update

# Add apache2
RUN aptitude install -y apache2

# Config Apache
ADD apache2/apache_default /etc/apache2/sites-available/000-default.conf
ADD apache2/supervisor.conf /etc/supervisor/conf.d/apache2.conf

# Add php5
RUN aptitude install -y libapache2-mod-php5 \
        php-apc \
        php-pear \
        php5-mysql \
        php5-mcrypt \
        php5-gd \
        php5-curl \
        php-apc \
        php5-intl \
        php5-sqlite \
        php5-xdebug  && \
        /usr/sbin/php5enmod mcrypt

# Config php5
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/php5/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/php5/cli/php.ini

# Download composer, phpunit and nvm
RUN wget -q -O /usr/local/bin/composer https://getcomposer.org/composer.phar && chmod +x /usr/local/bin/composer && \
    wget -q -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar && chmod +x /usr/local/bin/phpunit && \ 
    wget -q -O /bin/install-nvm.sh https://raw.githubusercontent.com/creationix/nvm/master/install.sh && chmod +x /bin/install-nvm.sh

# Add symofny installer
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony

# Set the entry directory
WORKDIR /var/www/html

# Expose the ports
EXPOSE 80 8000 8080

# Clean image
RUN rm -rf /var/lib/apt/lists/*

CMD ["/bin/run.sh"]
