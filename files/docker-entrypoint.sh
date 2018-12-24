#!/bin/bash
#set -e
# Recommend syntax for setting an infinite while loop
#service php7.2-fpm start
#service nginx start

set -e
# Recommend syntax for setting an infinite while loop
while :
do
	echo "Do something; hit [CTRL+C] to stop!"
done


#Extra line added in the script to run all command line arguments
exec "$@";
#Extra line added in the script to run all command line arguments
#exec "$@";
