#!/bin/bash

hostname rpi-desktop00.ctmug.net

apt install -y squid-deb-proxy-client

SERVER_IP=$(avahi-resolve-host-name -4 rpi-server.local | cut -f2)
echo "${SERVER_IP}   rpi-server.ctmug.net" >> /etc/hosts

apt update
apt install -y puppet
puppet apply --modulepath=modules/ .

#reboot
