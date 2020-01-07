#!/bin/bash

sudo apt install -y squid-deb-proxy-client
sudo apt update
sudo apt install -y puppet
sudo puppet apply --modulepath=modules/ .
