FROM lsiobase/ubuntu:focal
LABEL maintainer="Mike Weaver @_bashNinja"

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -yq && \
    apt-get install -yq software-properties-common apt-utils iptables && \
    echo "deb https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-4.2.list && \
    echo "deb https://repo.pritunl.com/stable/apt focal main" > /etc/apt/sources.list.d/pritunl.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv E162F504A20CDF15827F718D4B7C549A058F8B6B && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv 7568D9BB55FF9E5287D586017AE645C0CF8E292A && \
    apt-get --assume-yes update && \
    apt-get --assume-yes upgrade && \
    apt-get --assume-yes install pritunl mongodb-server wireguard && \
    # Cleanup
    apt-get clean -y && \
    apt-get autoremove -y && \
    rm -rfv /tmp/* /var/lib/apt/lists/* /var/tmp/* 

RUN \
    echo "* hard nofile 64000" >> /etc/security/limits.conf \
    echo "* soft nofile 64000" >> /etc/security/limits.conf \
    echo "root hard nofile 64000" >> /etc/security/limits.conf \
    echo "root soft nofile 64000" >> /etc/security/limits.conf

COPY root/ /
EXPOSE 51820 1194 443 80
VOLUME /config
