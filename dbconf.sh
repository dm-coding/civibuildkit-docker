#!/bin/bash

PASS=$(date | md5sum)
PASS=$(echo -n "${PASS//[[:space:]]/}" | sed -e 's/-//g')

service mysql start

echo "GRANT ALL ON *.* to 'amp'@'localhost' IDENTIFIED BY '$PASS' WITH GRANT OPTION;" | mysql

AMPCONF="parameters:
    mysql_type: dsn
    mysql_dsn: 'mysql://amp:$PASS@localhost:3306'
    perm_type: worldWritable
    httpd_type: apache24
services: {  }"

mkdir -p /root/.amp

echo "$AMPCONF" > /root/.amp/services.yml

echo "Include /root/.amp/apache.d/*.conf" >> /etc/apache2/apache2.conf

echo '{ "allow_root": true }' > /root/.bowerrc

git config --global url."https://".insteadOf "git://"
/buildkit/bin/composer config --global github-protocols https

echo "Finished running pr-configuration, will now install CiviCRM using buildkit buildscript."