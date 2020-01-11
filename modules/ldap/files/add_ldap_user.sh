#!/bin/bash

set -e

mkdir -p users

FIRST_NAME=${1:-John}
LAST_NAME=${2:-Doe}

LAST_UID=$(cat users/last_uid)
USER_UID=${3:-${LAST_UID}}

: "${LDAP_URI:=ldap://rpi-server.ctmug.net}"
: "${NFS_SERVER:=rpi-server.ctmug.net:/mnt/nfs-homes}"
: "${LDAP_ROOT:=dc=ctmug,dc=net}"

FIRST=$(echo ${FIRST_NAME} | tr '[:upper:]' '[:lower:]')
LAST=$(echo ${LAST_NAME} | tr '[:upper:]' '[:lower:]')
USER_NAME="${FIRST}.${LAST}"

echo "Creating user ${USER_NAME} uid ${USER_UID} for ${FIRST_NAME} ${LAST_NAME}..."
echo "\n"

cat <<EoF >users/${USER_NAME}.ldif
dn: cn=${USER_NAME},ou=Groups,${LDAP_ROOT}
objectClass: posixGroup
cn: ${USER_NAME}
gidNumber: ${USER_UID}

dn: uid=${USER_NAME},ou=People,${LDAP_ROOT}
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
uid: ${USER_NAME}
sn: ${LAST_NAME}
givenName: ${FIRST_NAME}
cn: ${FIRST_NAME} ${LAST_NAME}
displayName: ${FIRST_NAME} ${LAST_NAME}
uidNumber: ${USER_UID}
gidNumber: ${USER_UID}
userPassword: changeme
gecos: ${FIRST_NAME} ${LAST_NAME}
loginShell: /bin/bash
homeDirectory: /home/${USER_NAME}

dn: cn=${USER_NAME},ou=auto.home,ou=automount,ou=admin,${LDAP_ROOT}
cn: ${USER_NAME}
objectClass: top
objectClass: automount
automountInformation: -fstype=nfs,rw,hard,intr,nodev,exec,nosuid,rsize=8192,wsize=8192 ${NFS_SERVER}/${USER_NAME}
EoF

#cat ${USER_NAME}.ldif

set -x

ldapadd -x -D cn=admin,${LDAP_ROOT} -W -f users/${USER_NAME}.ldif

echo "Copying default home folder files..."
sudo rsync -a /etc/skel/ /mnt/nfs-homes/${USER_NAME}/
sudo chown -R ${USER_UID}:${USER_UID} /mnt/nfs-homes/${USER_NAME}

if [[ $USER_UID -eq $LAST_UID ]]; then
    echo $(expr $USER_UID + 1) > users/last_uid
fi
