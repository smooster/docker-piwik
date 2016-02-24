#!/bin/bash
set -e

if [ ! -e '/var/www/html/piwik.php' ]; then
	tar cf - --one-file-system -C /usr/src/piwik . | tar xf -
	chown -R nginx /var/www/html
fi

while /bin/true; do
  su -s "/bin/bash" -c "/usr/local/bin/php /var/www/html/console core:archive" nginx
  sleep 3600
done &

exec "$@"
