FROM bitnami/minideb-extras:stretch-r231
LABEL maintainer "Bitnami <containers@bitnami.com>"

# Install required system packages and dependencies
RUN install_packages cron libbz2-1.0 libc6 libcomerr2 libcurl3 libexpat1 libffi6 libfreetype6 libgcc1 libgcrypt20 libgmp10 libgnutls30 libgpg-error0 libgssapi-krb5-2 libhogweed4 libicu57 libidn11 libidn2-0 libjpeg62-turbo libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libldap-2.4-2 liblzma5 libmcrypt4 libmemcached11 libmemcachedutil2 libncurses5 libnettle6 libnghttp2-14 libp11-kit0 libpcre3 libpng16-16 libpq5 libpsl5 libreadline7 librtmp1 libsasl2-2 libsqlite3-0 libssh2-1 libssl1.0.2 libssl1.1 libstdc++6 libsybdb5 libtasn1-6 libtidy5 libtinfo5 libunistring0 libxml2 libxslt1.1 zlib1g
RUN apt-get update \
    && apt-get install -y nginx git --no-install-recommends \
    && mkdir -p /var/www/html/magento \
#    && useradd -u 1001 -m -d /var/www/html/magento -s /bin/bash magento \
    && useradd -u 1001 magento \
    && usermod -G magento www-data \ 
    && locale-gen en_US.UTF-8 \
    && export LANG=en_US.UTF-8 \
    && LC_ALL=en_US.UTF-8 \
    && apt-get install -y ca-certificates apt-transport-https wget \
    && wget -q https://packages.sury.org/php/apt.gpg -O- | sudo apt-key add - \
    && echo "deb https://packages.sury.org/php/ stretch main" | sudo tee /etc/apt/sources.list.d/php.list \
    && apt-get update \
#    && apt-get install -y php7.0 php7.0-fpm php7.0-cli php7.0-common php7.0-gd php7.0-mysql php7.0-mcrypt php7.0-curl php7.0-intl php7.0-xsl php7.0-mbstring php7.0-zip php7.0-bcmath php7.0-iconv php7.0-soap

    && apt-get install -y php7.2 php7.2-fpm php7.2-cli php7.2-common php7.2-gd php7.2-mysql php7.2-curl php7.2-intl php7.2-xsl php7.2-mbstring php7.2-zip php7.2-bcmath php7.2-iconv php7.2-soap
#RUN bitnami-pkg unpack libphp-7.1.25-21 --checksum c55887490c4242caaf4a7a9abefefaff71b5413cec6965b1e08a2795e4aff167

RUN sed -i -e '/pam_loginuid.so/ s/^#*/#/' /etc/pam.d/cron

ADD files/php-cli.ini /etc/php/7.0/cli/php.ini
ADD files/docker-entrypoint.sh  /docker-entrypoint.sh
ADD files/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD files/www.conf /etc/php/7.0/fpm/pool.d/www.conf
ADD files/php-fpm.ini /etc/php/7.0/fpm/php.ini
ADD files/default /etc/nginx/sites-available/default
ADD files/magento-nginx.conf /etc/nginx/sites-available/magento-nginx.conf
ADD files/install-php7.2-mcrypt.sh /tmp/install-php7.2-mcrypt.sh 

RUN sh /tmp/install-php7.2-mcrypt.sh \
    && cd /var/www/html/magento/ \
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
    && echo "121" \
    && chown -R magento:magento /var/www/html/magento/var/*

COPY rootfs /
ENV ALLOW_EMPTY_PASSWORD="no" \
    APACHE_HTTPS_PORT_NUMBER="443" \
    APACHE_HTTP_PORT_NUMBER="80" \
    BITNAMI_APP_NAME="magento" \
    BITNAMI_IMAGE_VERSION="2.3.0-debian-9-r9" \
    MAGENTO_ADMINURI="admin" \
#    MAGENTO_DATABASE_NAME="bitnami_magento" \
#    MAGENTO_DATABASE_PASSWORD="" \
#    MAGENTO_DATABASE_USER="bn_magento" \
    MAGENTO_EMAIL="user@example.com" \
    MAGENTO_FIRSTNAME="FirstName" \
    MAGENTO_HOST="127.0.0.1" \
    MAGENTO_LASTNAME="LastName" \
    MAGENTO_MODE="developer" \
    MAGENTO_PASSWORD="bitnami1" \
    MAGENTO_USERNAME="user" 
#    MARIADB_HOST="mariadb" \
#    MARIADB_PORT_NUMBER="3306" \
#    MARIADB_ROOT_PASSWORD="" \
#    MARIADB_ROOT_USER="root" \
#    MYSQL_CLIENT_CREATE_DATABASE_NAME="" \
#    MYSQL_CLIENT_CREATE_DATABASE_PASSWORD="" \
#    MYSQL_CLIENT_CREATE_DATABASE_PRIVILEGES="ALL" \
#    MYSQL_CLIENT_CREATE_DATABASE_USER="" \
#    PATH="/opt/bitnami/apache/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/mysql/bin:/opt/bitnami/magento/bin:$PATH"

EXPOSE 80 443

#ENTRYPOINT [ "/app-entrypoint.sh" ]
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["bash"]
#CMD [ "httpd", "-f", "/bitnami/apache/conf/httpd.conf", "-DFOREGROUND" ]
