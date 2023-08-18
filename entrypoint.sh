#!/bin/bash
PHP=$1

uid="$(id -u)"
gid="$(id -g)"

user="${APACHE_RUN_USER:-www-data}"
group="${APACHE_RUN_GROUP:-www-data}"

# strip off any '#' symbol ('#1000' is valid syntax for Apache)
pound='#'
user="${user#$pound}"
group="${group#$pound}"

# set user if not exist
if ! id "$user" &>/dev/null; then
    # get the user name
    : "${USER_NAME:=www-data}"
    # change the user name
    [[ "$USER_NAME" != "www-data" ]] &&
	usermod -l "$USER_NAME" www-data &&
	groupmod -n "$USER_NAME" www-data
    # update the user ID
    groupmod -o -g "$user" "$USER_NAME"
    # update the user-group ID
    usermod -o -u "$group" "$USER_NAME"
fi

JOOMLA_DB_HOST='localhost'
JOOMLA_DB_USER='joomla'
JOOMLA_DB_PASSWORD='joomla'
JOOMLA_DB_NAME='joomla'

service mysql start
service mariadb start

if [ ! -d administrator ] ; then

    # If there is no administrator directory then prepare for Kickstart

    # Ensure the MySQL Database is created
    php$PHP /makedb.php "$JOOMLA_DB_HOST" "$JOOMLA_DB_USER" "$JOOMLA_DB_PASSWORD" "$JOOMLA_DB_NAME"

    # Copy any backup files for restore
    if [ -d /restore ]
    then
        if [ "(ls -A /restore)" ]
        then
	        cp /restore/* /var/www/html
	        chown -R www-data:www-data /var/www/html
        fi
    fi

    a2enmod ssl
    a2enconf ssl
    ./generate_certs.sh

    echo >&2 "========================================================================"
    echo >&2
    echo >&2 "This server is now configured to restore Joomla!"
    echo >&2
    echo >&2 "Navigate to http://localhost/kickstart.php to restore"
    echo >&2 "You might need to add a port..."
    echo >&2
    echo >&2 "NOTE: You will need your database server address, database name,"
    echo >&2 "and database user credentials to restore."
    echo >&2
    echo >&2 "JOOMLA_DB_HOST='$JOOMLA_DB_HOST'"
    echo >&2 "JOOMLA_DB_USER='$JOOMLA_DB_USER'"
    echo >&2 "JOOMLA_DB_PASSWORD='$JOOMLA_DB_PASSWORD'"
    echo >&2 "JOOMLA_DB_NAME='$JOOMLA_DB_NAME'"
    echo >&2
    echo >&2 "If you have CiviCRM run civicrm-fix before navigating to front or back"
    echo >&2
    echo >&2 "========================================================================"

else

    echo >&2 "========================================================================"
    echo >&2
    echo >&2 "There is already a Joomla site ($SITE) in this container"
    echo >&2
    echo >&2 "Navigate to this containers http://localhost:{mapped_port}"
    echo >&2
    echo >&2 "JOOMLA_DB_HOST='$JOOMLA_DB_HOST'"
    echo >&2 "JOOMLA_DB_USER='$JOOMLA_DB_USER'"
    echo >&2 "JOOMLA_DB_PASSWORD='$JOOMLA_DB_PASSWORD'"
    echo >&2 "JOOMLA_DB_NAME='$JOOMLA_DB_NAME'"
    echo >&2
    echo >&2 "========================================================================"

fi

<<<<<<< HEAD
./generate_certs.sh
a2enmod ssl
a2enconf ssl
service apache2 start

echo >&2 "========================================================================"
echo >&2
echo >&2 "This server is now configured to restore Joomla!"
echo >&2
echo >&2 "Navigate to this containers http://localhost:{mapped_port}/kickstart.php"
echo >&2
echo >&2 "NOTE: You will need your database server address, database name,"
echo >&2 "and database user credentials to restore."
echo >&2
echo >&2 "JOOMLA_DB_HOST='$JOOMLA_DB_HOST'"
echo >&2 "JOOMLA_DB_USER='$JOOMLA_DB_USER'"
echo >&2 "JOOMLA_DB_PASSWORD='$JOOMLA_DB_PASSWORD'"
echo >&2 "JOOMLA_DB_NAME='$JOOMLA_DB_NAME'"
echo >&2
echo >&2 "========================================================================"

service apache2 start

tail -f /var/log/apache2/error.log -f /var/log/apache2/access.log
