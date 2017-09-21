#!/bin/bash
SUDO=''

if (( $EUID != 0 )); then SUDO='sudo -H'; fi;

## Configure SSH agent/keys
eval `ssh-agent -s`
ssh-keygen -t rsa -b 4096 -P "$0" -q
ssh-add

echo "Installing Pip..."
$SUDO easy_install pip && echo "Pip Installed." || (echo "Failed." && exit 1)

echo "Installing Ansible..."
$SUDO pip install ansible && echo "ansible Installed." || (echo "Failed." && exit 1)

HOSTSFILE=/etc/ansible/hosts && touch $HOSTSFILE
echo 127.0.0.1 | $SUDO tee -a $HOSTSFILE > /dev/null

