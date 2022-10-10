#!/bin/bash
cp /restore/* /var/www/html

echo "Hello!"

exec "$@"
