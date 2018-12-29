FROM kamil71/magento2.3:v2.3
LABEL maintainer "Kamil Khan"

# Install required system packages and dependencies
COPY rootfs/php.ini /opt/bitnami/php/etc/php.ini
COPY rootfs/bitnami.conf /bitnami/apache/conf/bitnami/bitnami.conf

RUN git clone https://github.com/ktpl-kamil/magento2_3.git /opt/bitnami/magento/htdocs \
    && cd /opt/bitnami/magento/htdocs \
    && composer install \
    && composer update \
    && echo "123456" \
    && php bin/magento deploy:mode:set production

RUN find /opt/bitnami/magento/htdocs -type d -print0 | xargs -0 chmod 775 && find /opt/bitnami/magento/htdocs -type f -print0 | xargs -0 chmod 755 /opt/bitnami/magento/htdocs && chown -R bitnami:daemon /opt/bitnami/magento/htdocs && chmod -R 777 /opt/bitnami/magento/htdocs/var

ENV ALLOW_EMPTY_PASSWORD="no" \
    APACHE_HTTPS_PORT_NUMBER="443" \
    APACHE_HTTP_PORT_NUMBER="80" \
    BITNAMI_APP_NAME="magento" \
    BITNAMI_IMAGE_VERSION="2.3.0-debian-9-r12" \ 
    MAGENTO_ADMINURI="admin" \ 
    MAGENTO_DATABASE_NAME="bitnami_magento" \ 
    MAGENTO_DATABASE_PASSWORD="magento_db_password" \ 
    MAGENTO_DATABASE_USER="bn_magento" \ 
    MAGENTO_EMAIL="user@example.com" \ 
    MAGENTO_FIRSTNAME="FirstName" \ 
    MAGENTO_HOST="shop.test.lafamilia-jo.com" \ 
    MAGENTO_LASTNAME="LastName" \ 
    MAGENTO_MODE="developer" \ 
    MAGENTO_PASSWORD="" \ 
    MAGENTO_USERNAME="user" \ 
    MARIADB_HOST="mariadb" \ 
    MARIADB_PORT_NUMBER="3306" \ 
    MARIADB_ROOT_PASSWORD="" \ 
    MARIADB_ROOT_USER="root" \ 
    MYSQL_CLIENT_CREATE_DATABASE_NAME="" \ 
    MYSQL_CLIENT_CREATE_DATABASE_PASSWORD="" \ 
    MYSQL_CLIENT_CREATE_DATABASE_PRIVILEGES="ALL" \ 
    MYSQL_CLIENT_CREATE_DATABASE_USER="" \
    PATH="/opt/bitnami/apache/bin:/opt/bitnami/php/bin:/opt/bitnami/php/sbin:/opt/bitnami/mysql/bin:/opt/bitnami/magento/bin:$PATH"

EXPOSE 80 443

ENTRYPOINT [ "/app-entrypoint.sh" ]
CMD [ "httpd", "-f", "/bitnami/apache/conf/httpd.conf", "-DFOREGROUND" ]
