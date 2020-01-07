#!/bin/bash

sudo hostname rpi-desktop00.henderb.net

sudo apt install -y squid-deb-proxy-client

SERVER_IP=$(avahi-resolve -4 rpi-server.local | cut -f2)
echo "${SERVER_IP}   rpi-server.henderb.net" >> /etc/hosts

sudo apt update
sudo apt install -y puppet
sudo puppet apply --modulepath=modules/ .
