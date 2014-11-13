#!/bin/sh

# Prep cache directory
/usr/sbin/squid3 -z -N -f /mnt/squid3/squid3.conf

# prep log ownership
chown -R proxy:proxy /mnt/log

# Run squid
/usr/sbin/squid3 -N -f /mnt/squid3/squid3.conf

