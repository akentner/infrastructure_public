#!/bin/sh

USER="ansible"
UID=1099
USER_HOME="/home/${USER}"
SSHDIR="${USER_HOME}/.ssh"
SSHPUB="https://raw.githubusercontent.com/akentner/infrastructure_public/main/.ssh/ansible_management.pub"
PASSWORD=$(tr -dc A-Za-z0-9 </dev/urandom | head -c 13; echo)

useradd -u $UID -s /bin/sh -U -p ${PASSWORD} $USER || true

mkdir -p "$SSHDIR"
chmod 700 "$SSHDIR"
touch "$SSHDIR/authorized_keys"
chmod 600 "$SSHDIR/authorized_keys"
chown -R "$USER:$USER" $USER_HOME

curl $SSHPUB >> $SSHDIR/authorized_keys


echo "$USER ALL=(ALL:ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/$USER

