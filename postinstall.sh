#!/bin/bash
rm -rf /var/www/html
ln -s /buildkit/build/civicrm /var/www/html

# DRUPAL (7)
if [ "$CIVITYPE" = "backdrop-demo" ]; then
    cp /buildkit/build/civicrm/sites/default/default.settings.php /buildkit/build/civicrm/sites/default/settings.php
    mkdir -p  /buildkit/build/civi/sites/default/files
    chmod 755 /buildkit/build/civi/sites/default/files
    chmod 755 /buildkit/build/civi/sites/default/settings.php
fi