FROM php:8.2-fpm

VOLUME "/home/project"
WORKDIR "/home/project"

RUN apt update
RUN apt upgrade -y  
RUN apt install -y libxml2-dev 
RUN apt install -y libldb-dev
RUN apt install -y libldap2-dev
RUN apt install -y libssl-dev
RUN apt install -y libxslt-dev
RUN apt install -y wget
RUN apt install -y graphviz
RUN apt install -y libzip-dev
#RUN apt install -y zlib-dev

RUN set -ex
RUN apt-get update
RUN apt-get install -y vim curl debconf subversion apt-transport-https apt-utils build-essential locales acl mailutils wget
RUN apt-get install -y libjpeg-dev libpng-dev libmcrypt-dev unzip git
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-jpeg
RUN pecl install -o -f xdebug && rm -rf /tmp/pear
RUN docker-php-ext-install -j5 gd mysqli pdo_mysql xsl zip
#RUN docker-php-ext-install -j5 json
   
#install mailhog     
RUN apt-get update
RUN apt-get install --no-install-recommends --assume-yes --quiet ca-certificates curl git
RUN rm -rf /var/lib/apt/lists/*
RUN curl -Lsf 'https://storage.googleapis.com/golang/go1.8.3.linux-amd64.tar.gz' | tar -C '/usr/local' -xvzf -
ENV PATH /usr/local/go/bin:$PATH
RUN go get github.com/mailhog/mhsendmail
RUN cp /root/go/bin/mhsendmail /usr/bin/mhsendmail

RUN docker-php-ext-configure intl
RUN docker-php-ext-install intl

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev && rm -r /var/lib/apt/lists/*
RUN docker-php-ext-configure imap --with-kerberos --with-imap-ssl \
    && docker-php-ext-install imap

# Install YAML extension
RUN apt-get update -y
RUN apt-get install libyaml-dev -y
RUN pecl install yaml && echo "extension=yaml.so" > /usr/local/etc/php/conf.d/ext-yaml.ini
    
# Goto temporary directory.
WORKDIR /tmp

# Install composer  
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer  
RUN mkdir /var/composer  
ENV COMPOSER_HOME /var/composer  
ENV COMPOSER_ALLOW_SUPERUSER 1 

WORKDIR "/home/project"

# Install symfony  
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN curl -sS https://get.symfony.com/cli/installer | bash
RUN mv /root/.symfony5/bin/symfony /usr/local/bin/symfony

CMD ["php-fpm"]
