#!/bin/bash
rm -rf /var/www/html
ln -s /buildkit/build/civicrm /var/www/html
chown -R www-data:www-data /buildkit/build/civicrm

# DRUPAL (7)
if [ "$CIVITYPE" = "backdrop-demo" ]; then
    cp /buildkit/build/civicrm/sites/default/default.settings.php /buildkit/build/civicrm/sites/default/settings.php
    mkdir -p     /buildkit/build/civicrm/sites/default/files
    chmod 755 -R /buildkit/build/civicrm/sites/default/files
    chmod 755    /buildkit/build/civicrm/sites/default/settings.php
fi
