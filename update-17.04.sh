#!/bin/bash

# root check
if [[ $EUID -ne 0 ]]; then
    echo "################################";
    echo "## YOU ARE NOT RUNNING AS ROOT #";
    echo "################################";
    echo "#";
    echo "# USAGE: sudo $0";
    exit;
fi

control_c()
# run if user hits control-c
{
  echo -en "\n*** Ouch! Exiting ***\n"
  exit $?
}
# trap keyboard interrupt (control-c)
trap control_c SIGINT

##### SETUP FUNCTIONS ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

export DEBIAN_FRONTEND=noninteractive

function aptGetInstall {
  apt install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" "$@"
}

function addRepository {
  add-apt-repository -y "$@"
}

##### UPDATE ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

apt update
apt upgrade
apt dist-upgrade

# python-software-properties installs add-apt-repository
aptGetInstall python-software-properties

##### REPOSITORIES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

# Git
addRepository ppa:git-core/ppa

# Java 8
addRepository ppa:webupd8team/java

# Chrome
if [ ! -f /etc/apt/sources.list.d/google-chrome.list ]; then
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
  sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
fi

### SPECIFIC STUFF LUIS USES

# Various, in specific, truecrypt
addRepository ppa:stefansundin/truecrypt

# Equalizer
addRepository ppa:nilarimogard/webupd8

# Libre Office
addRepository ppa:libreoffice/ppa

# Simple screen recorder
addRepository ppa:maarten-baert/simplescreenrecorder

##### UPDATE REPOSITORIES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 
apt -y update
apt -y autoremove
