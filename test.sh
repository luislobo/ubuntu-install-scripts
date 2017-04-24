#!/bin/bash

if [[ $EUID -eq 0 ]]; then
  echo "You must NOT run this script as ROOT" 2>&1
  exit 1
fi

control_c()
# run if user hits control-c
{
  echo -en "\n*** Ouch! Exiting ***\n"
  exit $?
}
# trap keyboard interrupt (control-c)
trap control_c SIGINT

### URLs. Get them from their sources

# https://github.com/creationix/nvm#install-script
nvm_url="https://raw.githubusercontent.com/creationix/nvm/master/nvm.sh"

# https://github.com/robbyrussell/oh-my-zsh#via-wget
oh_my_zsh_url="https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

##### SETUP FUNCTIONS ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 

export DEBIAN_FRONTEND=noninteractive

function installFromUrl {
  wget --quiet --output-document=- $1 | sudo dpkg --install -
}

function aptGetInstall {
  sudo apt-get install -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" "$@"
}

function aptGetRemove {
  sudo apt-get remove -y "$@"
}

##### INSTALL CLI PACKAGES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 

# ZSH, OhMyZSH, its plugins & set as default for current user
aptGetInstall zsh
sh -c "$(curl -fsSL $oh_my_zsh_url)" -s --batch && echo install zsh complete

aptGetInstall mc
