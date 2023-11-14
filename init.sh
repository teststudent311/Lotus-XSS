#!/bin/bash
groupadd --gid "$PUID" lotusxss || true
useradd --system --uid "$PUID" --gid "$PGID" lotusxss || true
chown lotusxss: /var/www/html -R || true
chown lotusxss /var/log/apache2/error.log || true
chown lotusxss /var/log/apache2/other_vhosts_access.log || true
chmod 777 /var/www/html/assets/img || true
echo "Launching application with UID $PUID and GID $PGID"
runuser -u lotusxss apache2-foreground
