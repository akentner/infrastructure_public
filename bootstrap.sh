#!/bin/sh

ANSIBLE_USER="ansible"
ANSIBLE_UID=1099
ANSIBLE_HOME="/home/${ANSIBLE_USER}"
SSHDIR="${ANSIBLE_HOME}/.ssh"
SSHPUB="https://raw.githubusercontent.com/akentner/infrastructure_public/main/.ssh/ansible_management.pub"
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

useradd -u $ANSIBLE_UID -s /bin/sh -U -p ${PASSWORD} $ANSIBLE_USER || true

mkdir -p "$SSHDIR"
chmod 700 "$SSHDIR"
touch "$SSHDIR/authorized_keys"
chmod 600 "$SSHDIR/authorized_keys"
chown -R "$ANSIBLE_USER:$ANSIBLE_USER" $ANSIBLE_HOME

curl $SSHPUB >> $SSHDIR/authorized_keys


echo "$ANSIBLE_USER ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/$ANSIBLE_USER

