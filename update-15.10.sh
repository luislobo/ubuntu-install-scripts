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
  apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" "$@"
}

function addRepository {
  add-apt-repository -y "$@"
}

##### UPDATE ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

apt-get update
apt-get upgrade
apt-get dist-upgrade

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
  sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list'
fi

# Nginx
addRepository ppa:nginx/development

# MongoDB 3.2
if [ ! -f /etc/apt/sources.list.d/mongodb-org-3.2.list ]; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
  echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | tee /etc/apt/sources.list.d/mongodb-org-3.2.list
fi
### SPECIFIC STUFF LUIS USES

# spotify
if [ ! -f /etc/apt/sources.list.d/spotify.list ]; then
  apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  echo deb http://repository.spotify.com stable non-free | tee /etc/apt/sources.list.d/spotify.list
fi

# Maria DB
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386] http://sfo1.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu wily main'

# Intel graphics card key
# apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A902DDA375E52366

# Various, in specific, truecrypt
addRepository ppa:stefansundin/truecrypt

# Clementine
addRepository ppa:me-davidsansome/clementine-dev

# Equalizer
addRepository ppa:nilarimogard/webupd8

# Libre Office
addRepository ppa:libreoffice/ppa

# Wine
addRepository ppa:ubuntu-wine/ppa

##### UPDATE REPOSITORIES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 
apt-get update
