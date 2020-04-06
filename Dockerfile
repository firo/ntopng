FROM ubuntu:18.04

# Install packages
RUN apt-get clean all && apt-get update && apt-get -y dist-upgrade
RUN apt-get install -y systemd net-tools curl wget perl libdigest-perl-md5-perl lsb-release gnupg
RUN curl -s --remote-name http://packages.ntop.org/apt/18.04/all/apt-ntop.deb
RUN dpkg -i apt-ntop.deb
RUN rm -rf apt-ntop.deb
RUN apt-get update
RUN apt-get -y -q install ntopng redis-server libpcap0.8 
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN sed -i "s/::1/ /g" /etc/redis/redis.conf

# Run deamons
RUN sudo service redis-server start
# RUN sudo service ntopng start

# Expose NTOPNG standard http port
EXPOSE 3000/tcp
