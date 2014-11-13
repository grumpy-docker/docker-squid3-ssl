# Dockerfile for Squid3, with SSL enabled.
# http://www.squid-cache.org/

# expects mounted files:
# /mnt/squid3/squid3.conf
# /mnt/squid3/key
# /mnt/squid3/crt

FROM stackbrew/ubuntu:saucy
MAINTAINER Alex Sherwin <alex.sherwin@gmail.com>

RUN echo "deb http://archive.ubuntu.com/ubuntu saucy main" > /etc/apt/sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ saucy-updates main" >> /etc/apt/sources.list
RUN echo "deb http://security.ubuntu.com/ubuntu saucy-security main" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu saucy main" >> /etc/apt/sources.list
RUN echo "deb-src http://archive.ubuntu.com/ubuntu/ saucy-updates main" >> /etc/apt/sources.list
RUN echo "deb-src http://security.ubuntu.com/ubuntu saucy-security main" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get -y upgrade

# Install dependencies
RUN apt-get -y install apache2 logrotate squid-langpack ca-certificates
RUN apt-get -y install libgssapi-krb5-2 libltdl7 libecap2 libnetfilter-conntrack3

# Install from locally generated .deb files
ADD debs /root/
RUN dpkg -i /root/*.deb
RUN rm /root/*.deb

# Create cache directory
RUN mkdir /srv/squid3
RUN chown proxy:proxy /srv/squid3
RUN touch /srv/squid3/init_volume
VOLUME /srv/squid3

# Install run.sh
ADD bin /usr/local/bin/
RUN chmod 755 /usr/local/bin/run.sh 

EXPOSE 3128
CMD ["/usr/local/bin/run.sh"]
