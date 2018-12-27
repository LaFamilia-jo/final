#!/bin/bash
#set -e
# Recommend syntax for setting an infinite while loop
su magento

cd /var/www/html/magento/

php bin/magento setup:config:set --http-cache-hosts=varnish:80

exit

service php7.2-fpm start
service nginx start

#Extra line added in the script to run all command line arguments
exec "$@";
#Extra line added in the script to run all command line arguments
#exec "$@";
