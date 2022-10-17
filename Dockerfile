FROM thoni56/lamp:bionic-7.4
LABEL maintainer="Thomas Nilefalk <thomas@nilefalk.se>"

# Download Akeeba kickstart and extract to web volume
RUN set -ex; \
	curl -o kickstart.zip -SL https://www.akeeba.com/download/akeeba-kickstart/7-1-2/kickstart-core-7-1-2-zip.raw; \
	unzip kickstart.zip -d /var/www/html; \
	chown -R www-data:www-data /var/www/html/*

VOLUME restore

# Copy init scripts
COPY entrypoint.sh /entrypoint.sh
RUN \
    chmod 755 /entrypoint.sh
COPY makedb.php /makedb.php

ENTRYPOINT ["/entrypoint.sh"]
CMD ["apachectl", "-DFOREGROUND"]
