FROM debian:buster


RUN apt-get update && apt-get -y dist-upgrade && apt-get -y --no-install-recommends install wget gnupg
RUN wget -O - http://deb.kamailio.org/kamailiodebkey.gpg | apt-key add - 
RUN wget http://pkg.yeti-switch.org/key.gpg -O - | apt-key add -
RUN echo "deb http://deb.kamailio.org/kamailio52 buster main" >> /etc/apt/sources.list
RUN echo "deb http://pkg.yeti-switch.org/debian/buster unstable main ext" >> /etc/apt/sources.list
RUN wget --no-check-certificate https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add - && echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" >> /etc/apt/sources.list

RUN apt-get update && apt-get -y --no-install-recommends install build-essential devscripts \
    ca-certificates apt-transport-https debhelper fakeroot lintian python-jinja2 \
    git-changelog python-setuptools lsb-release curl

ADD . /build/yeti-lb/

WORKDIR /build/yeti-lb/
CMD make package

