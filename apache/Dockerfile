FROM debian:jessie
MAINTAINER Martín Anacabe <anacabe.martin@gmail.com>

# Set LANG
RUN export LANG=C.UTF-8

# Add sudo and aptitude
RUN apt-get update && apt-get install -y sudo aptitude && aptitude safe-upgrade -y

# Add utils
RUN aptitude install -y \
    acl \   
    curl \
    git \
    sqlite \
    vim \
    wget

# Add apache2
RUN aptitude install -y apache2

# Add supervisor
RUN aptitude install -y supervisor
RUN mkdir -p /var/log/supervisor 

# Config Apache
ADD apache2/apache_default /etc/apache2/sites-available/000-default.conf
ADD apache2/supervisor.conf /etc/supervisor/conf.d/apache2.conf

# Add php5.6
ENV PHP_VERSION php5
RUN aptitude install -y \
    libapache2-mod-$PHP_VERSION \
    php-pear \
    $PHP_VERSION-apcu \
    $PHP_VERSION-curl \
    $PHP_VERSION-gd \
    $PHP_VERSION-intl \
    $PHP_VERSION-mcrypt \
    $PHP_VERSION-mysqlnd \
    $PHP_VERSION-sqlite \
    $PHP_VERSION-xdebug

# Config php5.6
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/$PHP_VERSION/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/$PHP_VERSION/apache2/php.ini && \
    sed -i 's/;\(date\.timezone =\)/\1 America\/Argentina\/Buenos_Aires/g' /etc/$PHP_VERSION/cli/php.ini

# Download composer, phpunit and nvm
RUN wget -q -O /usr/local/bin/composer https://getcomposer.org/composer.phar && chmod +x /usr/local/bin/composer && \
    wget -q -O /usr/local/bin/phpunit https://phar.phpunit.de/phpunit-5.7.phar && chmod +x /usr/local/bin/phpunit && \
    wget -q -O /bin/install-nvm.sh https://raw.githubusercontent.com/creationix/nvm/master/install.sh && chmod +x /bin/install-nvm.sh

# Add symofny installer
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony && chmod a+x /usr/local/bin/symfony

# Set the entry directory
WORKDIR /var/www/html

# Expose the ports
EXPOSE 80 8000 8080

# Clean image
# RUN rm -rf /var/lib/apt/lists/*

# Add image configuration and scripts
ADD scripts/*.sh /bin/

# Set permissions of scripts
RUN chmod 755 /bin/*.sh

# Add sections for more utils
RUN aptitude install -y 7zip-full \
    && rm -rf /var/lib/apt/lists/*

CMD ["/bin/run.sh"]
