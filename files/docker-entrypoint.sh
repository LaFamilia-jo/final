#!/bin/bash
#set -e
# Recommend syntax for setting an infinite while loop
service php7.2-fpm start
service nginx start

#Extra line added in the script to run all command line arguments
exec "$@";
#Extra line added in the script to run all command line arguments
#exec "$@";
