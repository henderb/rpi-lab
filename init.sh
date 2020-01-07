#!/bin/bash

hostname rpi-desktop00.henderb.net

apt install -y squid-deb-proxy-client

SERVER_IP=$(avahi-resolve-host-name -4 rpi-server.local | cut -f2)
echo "${SERVER_IP}   rpi-server.henderb.net" >> /etc/hosts

apt update
apt install -y puppet
puppet apply --modulepath=modules/ .

#reboot
