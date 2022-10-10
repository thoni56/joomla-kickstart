#!/bin/bash
cp /restore/* /var/www/html
chown -r www-data:www-data /var/www/html

exec "$@"
