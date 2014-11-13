#!/bin/sh

# Prep cache directory
/usr/sbin/squid3 -z -N -f /mnt/squid3/squid3.conf

# Run squid
/usr/sbin/squid3 -N -f /mnt/squid3/squid3.conf

