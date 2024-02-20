#!/bin/bash

set -e

cd /srv/bedrock

composer install

wp core install --url=$WP_HOME \
  --title=bedrock \
  --admin_user=dev \
  --admin_email=admin@example.com \
  --admin_password=dev

wp package install aaemnnosttv/wp-cli-login-command \
  || echo 'wp-cli-login-command is already installed'

wp login install --activate --yes --skip-plugins --skip-themes

wp login as 1

/usr/bin/supervisord -c /etc/supervisord.conf > /dev/null

chown -R www-data:www-data /srv/bedrock/app/*/*
find /srv/bedrock/app/*/*/ -type d -exec chmod 0755 {} \;
find /srv/bedrock/app/*/*/ -type f -exec chmod 644 {} \;
