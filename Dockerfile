FROM bitnami/minideb-extras:stretch-r231
LABEL maintainer "Kamil Pathan"

# Install required system packages and dependencies
RUN install_packages cron libbz2-1.0 libc6 libcomerr2 libcurl3 libexpat1 libffi6 libfreetype6 libgcc1 libgcrypt20 libgmp10 libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu57 libidn11 libidn2-0 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses5 libnettle6 libnghttp2-14 libp11-kit0 libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.0.2 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5 libtinfo5 libunistring0 libxml2 libxslt1.1 zlib1g
RUN apt-get update \
    && apt-get install -y nginx git --no-install-recommends \
    && mkdir -p /var/www/ \
    && useradd -u 1001 -m -d /var/www/html/ -s /bin/bash magento \
    && mkdir -p /var/www/html/magento \
#    && useradd -u 1001 magento \
    && usermod -G magento www-data \ 
    && locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && LC_ALL=en_US.UTF-8 \
    && apt-get install -y ca-certificates apt-transport-https wget \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
    && apt-get install -y php7.2 php7.2-fpm php7.2-cli php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap \
    && curl -sS https://getcomposer.org/installer | php -- \
    --install-dir=/usr/bin \
    --filename=composer 

RUN sed -i -e '/pam_loginuid.so/ s/^#*/#/' /etc/pam.d/cron

ADD files/php-cli.ini /etc/php/7.2/cli/php.ini
ADD files/docker-entrypoint.sh  /docker-entrypoint.sh
ADD files/php-fpm.conf /etc/php/7.2/fpm/php-fpm.conf
ADD files/www.conf /etc/php/7.2/fpm/pool.d/www.conf
ADD files/php-fpm.ini /etc/php/7.2/fpm/php.ini
ADD files/default /etc/nginx/sites-available/default
ADD files/magento-nginx.conf /etc/nginx/sites-available/magento-nginx.conf
ADD files/install-php7.2-mcrypt.sh /tmp/install-php7.2-mcrypt.sh 
#ADD files/varnish.vcl /etc/varnish/default.vcl

RUN sh /tmp/install-php7.2-mcrypt.sh \
    && cd /var/www/html/magento/ \
    && ls -lhtra \
    && git clone https://github.com/ktpl-kamil/magento2.3.git . \
    && chown -R magento:magento /var/www/html/magento \
#    && su magento && composer install \
    && cd /var/www/html/magento \
    && rm -rf generated \
    && su magento \
    && php bin/magento sampledata:deploy \
    && php bin/magento setup:upgrade \
    && cd /var/www/html/magento/ \
    && chown -R magento:magento generated \
    && su magento \
    && php bin/magento deploy:mode:set production \
    && php bin/magento setup:config:set --http-cache-hosts=varnish:80 \
    && php bin/magento config:set --scope=default --scope-code=0 system/full_page_cache/caching_application 2 \
    && php bin/magento admin:user:create --admin-user="kamil" --admin-password="123123q" --admin-email="kamil.pathan@krishtechnolabs.com" --admin-firstname="kamil" --admin-lastname="Admin" \
    && cd /var/www/html/magento/ \
    && chmod -R 775 /var/www/html/magento/var \
    && apt-get remove -y curl git net-tools vim \
    && chmod -R 777 /var/www/html/magento/generated \
    && chown -R magento:magento /var/www/html/magento/ \
    && rm -rf update LICENSE.txt LICENSE_AFL.txt Gruntfile.js.sample COPYING.txt CHANGELOG.md grunt-config.json.sample phpserver php.ini.sample package.json.sample nginx.conf.sample var/* \
#    && rm -rf update LICENSE.txt LICENSE_AFL.txt Gruntfile.js.sample COPYING.txt CHANGELOG.md app/code app/design dev index.php grunt-config.json.sample lib phpserver php.ini.sample package.json.sample nginx.conf.sample var/* \
    && chmod +x /docker-entrypoint.sh 

ENV ALLOW_EMPTY_PASSWORD="no" \
    MAGENTO_USERNAME="user" 

EXPOSE 80 443

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
