#!/bin/bash

FIRST_NAME=${1:-John}
LAST_NAME=${2:-Doe}

: "${LDAP_URI:=ldap://rpi-server.ctmug.net}"
: "${LDAP_ROOT:=dc=ctmug,dc=net}"

FIRST=$(echo ${FIRST_NAME} | tr '[:upper:]' '[:lower:]')
LAST=$(echo ${LAST_NAME} | tr '[:upper:]' '[:lower:]')
USER_NAME="${FIRST}.${LAST}"

set -x

ldapdelete -D cn=admin,${LDAP_ROOT} -W "cn=${USER_NAME},ou=Groups,${LDAP_ROOT}" "uid=${USER_NAME},ou=People,${LDAP_ROOT}" "cn=${USER_NAME},ou=auto.home,ou=automount,ou=admin,${LDAP_ROOT}"

#if [ ${USER_NAME} ]; then
#    sudo rm -rf /mnt/nfs-homes/${USER_NAME}/
#fi
