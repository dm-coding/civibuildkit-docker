#!/bin/bash

# Check for a passed in DOCKER_UID environment variable. If it's there
# then ensure that the www-data user is set to this UID. That way we can
# easily edit files from the host.
if [ -n "$DOCKER_UID" ]; then
  printf "Updating UID...\n"
  # First see if it's already set.
  current_uid=$(getent passwd www-data | cut -d: -f3)
  if [ "$current_uid" -eq "$DOCKER_UID" ]; then
    printf "UIDs already match.\n"
  else
    printf "Updating UID from %s to %s.\n" "$current_uid" "$DOCKER_UID"
    usermod -u "$DOCKER_UID" www-data
  fi
fi

## Ensure that www-data user has permission to all files (eg /var/www/.amp, /var/www/civicrm/civicrm-buildkit/build/)
chown -R www-data:www-data /var/www/

# If apache was started by civi-download-tools, stop it, so it can be properly
# started by runit
if ps -eFH | egrep [a]pache2 >/dev/null; then
  /usr/sbin/apache2ctl stop
fi
export PATH=/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin
set -- "$@" -P /etc/service

#!/bin/bash
export > /etc/envvars
exec /usr/sbin/runsvdir-start