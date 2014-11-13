#!/bin/sh

# Prep cache directory
echo "Prepping cache dir..."
/usr/sbin/squid3 -z -N -f /mnt/squid3/squid3.conf

# prep log ownership
echo "Fixing /mnt/log permissions"
chown -R proxy:proxy /mnt/log

# Run squid
echo "Starting squid3..."
/usr/sbin/squid3 -N -f /mnt/squid3/squid3.conf

echo "squid3 has stopped"
