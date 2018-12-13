FROM ubuntu:16.04

MAINTAINER Tonu V

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y vim software-properties-common python-software-properties apt-transport-https curl zip language-pack-en-base net-tools nginx git \
    && apt-get update \
    && locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && LC_ALL=en_US.UTF-8 \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-intl php7.0-xsl php7.0-mbstring php7.0-zip php7.0-bcmath php7.0-iconv php7.0-soap \
#    && apt-get remove -y --purge software-properties-common python-software-properties \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && apt-get clean \
    && useradd -u 1001 magento \
    && usermod -G magento www-data \
    && curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer \
    && mkdir -p /var/www/html/magento \
#    && cp -arpv  /var/www/html/magento \
    && cd /var/www/html/magento \
    && git clone https://github.com/ktpl-kamil/test.git .

WORKDIR /var/www/html/magento

ADD files/php-cli.ini /etc/php/7.1/cli/php.ini
ADD files/docker-entrypoint.sh  /docker-entrypoint.sh
ADD files/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD files/www.conf /etc/php/7.0/fpm/pool.d/www.conf
ADD files/php-fpm.ini /etc/php/7.0/fpm/php.ini
ADD files/default /etc/nginx/sites-available/default
ADD files/magento-nginx.conf /etc/nginx/sites-available/magento-nginx.conf

ARG CACHEBUST=1
COPY /mnt/data/env.php ./app/etc/env.php 
COPY /mnt/data/composer.json ./composer.json
COPY /mnt/data/config.php ./app/config.php
COPY /mnt/data/auth.json ./auth.json



RUN chown -R magento:magento /var/www/html/magento \
#    && su magento #&& composer install \
    && su magento \
    && php bin/magento setup:upgrade && php bin/magento deploy:mode:set production

RUN mkdir /run/php

EXPOSE 22
EXPOSE 9000
EXPOSE 80

ENTRYPOINT ["./root/docker-entrypoint.sh"]

