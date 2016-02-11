#!/bin/bash

# DRUPAL (7)
if [ "$CIVITYPE" = "backdrop-demo" ]; then
    cp /buildkit/build/civicrm/sites/default/default.settings.php /buildkit/build/civicrm/sites/default/settings.php
    mkdir -p     /buildkit/build/civicrm/sites/default/files
    chmod 755 -R /buildkit/build/civicrm/sites/default/files
    chmod 755    /buildkit/build/civicrm/sites/default/settings.php
fi

rm -rf /var/www/html
mv /buildkit/build/civicrm /var/www/html
chown -R www-data:www-data /var/www/html

find /etc/apache2 -type f -exec sed -i -e 's/AllowOverride None/AllowOverride All/g' {} \;
crontab -u www-data -l | { cat; echo "*/15 * * * * /buildkit/bin/drush --root=/var/www/html core-cron --yes"; } | crontab -u www-data -