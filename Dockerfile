FROM ubuntu:16.04

MAINTAINER Tonu V

ENV DEBIAN_FRONTEND=noninteractive
ENV host=10.16.16.92

RUN apt-get update \
    && apt-get install -y vim software-properties-common python-software-properties apt-transport-https curl zip language-pack-en-base net-tools nginx git --no-install-recommends \
    && apt-get update \
    && locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && LC_ALL=en_US.UTF-8 \
    && add-apt-repository -y ppa:ondrej/php \
    && apt-get update \
    && apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-intl php7.0-xsl php7.0-mbstring php7.0-zip php7.0-bcmath php7.0-iconv php7.0-soap --no-install-recommends \
    && apt-get remove -y --purge software-properties-common python-software-properties \
    && rm -rf /var/lib/apt/lists/* \
    && echo "daemon off;" >> /etc/nginx/nginx.conf \
    && apt-get clean \
    && useradd -u 1001 magento \
    && usermod -G magento www-data \
    && curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer \
    && mkdir -p /var/www/html/magento \
    && cd /var/www/html/magento 
#ARG CACHEBUST=1

ADD files/php-cli.ini /etc/php/7.0/cli/php.ini
ADD files/docker-entrypoint.sh  /docker-entrypoint.sh
ADD files/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD files/www.conf /etc/php/7.0/fpm/pool.d/www.conf
ADD files/php-fpm.ini /etc/php/7.0/fpm/php.ini
ADD files/default /etc/nginx/sites-available/default
ADD files/magento-nginx.conf /etc/nginx/sites-available/magento-nginx.conf

#ARG CACHEBUST=1
RUN cd /var/www/html/magento/ \
    && ls -lhtra \
    && git clone https://github.com/ktpl-kamil/final.git . \
    && chown -R magento:magento /var/www/html/magento \
#    && su magento #&& composer install \
    && su magento \
    && php bin/magento setup:upgrade && bin/magento deploy:mode:set production && exit \
    && chown -R magento:magento /var/www/html/magento \
    && chmod -R 775 /var/www/html/magento/var/* \
    && mkdir /run/php \
    && apt-get remove -y curl git net-tools vim \
    && rm -rf update LICENSE.txt LICENSE_AFL.txt Gruntfile.js.sample COPYING.txt CHANGELOG.md app/code app/design dev index.php grunt-config.json.sample lib phpserver php.ini.sample package.json.sample nginx.conf.sample var/* \
    && chmod +x /dociker-entrypoint.sh 

RUN echo $host \
    && chown -R magento:magento /var/www/html/magento/var/*

#WORKDIR /var/www/html/magento
#COPY /mnt/data/env.php .
#COPY /mnt/data/composer.json ./composer.json
#COPY /mnt/data/config.php ./app/config.php
#COPY /mnt/data/auth.json ./auth.json
EXPOSE 22 9000 80

#RUN ["chmod", "+x", "/docker-entrypoint.sh"]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]


