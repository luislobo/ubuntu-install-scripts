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
oh_my_zsh_url="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

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

aptGetInstall oracle-java8-installer oracle-java8-set-default
update-java-alternatives -s java-8-oracle

# Very basic Linux build tools
aptGetInstall build-essential make

# ZSH, OhMyZSH, its plugins & set as default for current user
aptGetInstall zsh
sh -c "$(wget $oh_my_zsh_url -O -)"
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="amuse"/g' ~/.zshrc

# Basic Common tools
aptGetInstall mc htop curl ntp ntfs-config

# Compression tools
aptGetInstall p7zip-full unrar

# Git and tig
aptGetInstall git

# Mercurial
aptGetInstall mercurial

# Byobu and sets byobu as an available shell
aptGetInstall byobu

# nvm, node and modules
sh -c "$(wget -qO- $nvm_url)"
export NVM_DIR="$HOME/.nvm"
echo $NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 6
nvm use 6
nvm alias default 6
which node
which npm
node --version
npm --version
npm install npm@latest -g
npm --version

# NPM modules
npm install -g sails bower grunt-cli pm2 mocha jshint eslint gulp karma coffee-script dependency-check node-inspector npm-check-updates bower-check-updates

# ffmpeg
aptGetInstall ffmpeg

# Test disk (recovery tools)
aptGetInstall testdisk

# iostat
aptGetInstall sysstat

# iotop
aptGetInstall iotop

# nethogs - View network and processes
aptGetInstall nethogs

# network TOP
aptGetInstall iftop

# whois
aptGetInstall whois

# Install preload (speeds up stuff)
aptGetInstall preload

# Enhances Notebook Batery Life
aptGetInstall tlp tlp-rdw
sudo tlp start

# Nginx
aptGetInstall nginx

# MongoDB
aptGetInstall libkrb5-dev
aptGetInstall mongodb-org

# Redis
aptGetInstall redis-server

# SQLite
aptGetInstall sqlite

# Memcached
aptGetInstall memcached

# Encrypt FS utils
aptGetInstall ecryptfs-utils

# Gnome Partition Editor
aptGetInstall gparted

# Fabric tool
aptGetInstall fabric

# DKMS - updates things like virtualbox when a new kernel appears
aptGetInstall dkms

# Linux containers daemon
aptGetInstall lxd

# Better Deb installer
aptGetInstall gdebi

##### GUI PACKAGES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

# Anonymous PRO font
aptGetInstall ttf-anonymous-pro

# TortoiseHG
aptGetInstall tortoisehg

# Meld
aptGetInstall meld

# Virtualbox
aptGetInstall virtualbox virtualbox-guest-additions-iso

# Chrome
aptGetInstall google-chrome-stable

# Unity Tweak tool
aptGetInstall unity-tweak-tool

# Indicator Multiload
aptGetInstall indicator-multiload

### LUIS SPECIFIC STUFF

# spotify
aptGetInstall spotify-client

# zsync
aptGetInstall zsync

# Screen profiles
aptGetInstall arandr

# Hardware info
aptGetInstall hwinfo

# Install Atom Editor
installFromUrl https://atom.io/download/deb

# Openvpn client
aptGetInstall openvpn network-manager-openvpn

# Better volume control (have to run it manually as it does not replace built-in)
aptGetInstall pavucontrol

# WM ctrl to send messages to windows
aptGetInstall wmctrl

# Samba
aptGetInstall samba

# Pdf MOD
aptGetInstall pdfmod

# Logitech Unified Receiver Manager
aptGetInstall solaar

# Pulse audio equalizer
aptGetInstall pulseaudio-equalizer

# GStreamer Plugin for wma in Clementine
aptGetInstall gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse

# Compiz
aptGetInstall compizconfig-settings-manager

# use compiz settings manager and change this settings
# Launcher Reveal Pressure = 3
# Launcher Edge Stop Overcome Pressure = 15
# Pressure Decay Rate = 3
# Edge Stop Velocity = 10
# Sync to VBlank = false

# Advanced volume control
aptGetInstall pavucontrol

# skype
# First, libraries so that skype looks correctly on Ubuntu 64
aptGetInstall skype

# Truecrypt
aptGetInstall truecrypt

# Record my desktop
aptGetInstall gtk-recordmydesktop

# Clementine
aptGetInstall clementine

# VLC
aptGetInstall vlc

# GIMP
aptGetInstall gimp gimp-plugin-registry

# Feh
aptGetInstall feh

# Wine
aptGetInstall wine winetricks

# Simple Screen Recorder
aptGetInstall simplescreenrecorder-lib:i386 simplescreenrecorder

# remove fonts-unfonts-core because it makes java render funny
aptGetRemove -y fonts-unfonts-core

# install exfat format. Needed for SD cards used in phones
aptGetInstall exfat-fuse exfat-utils

# remove zeitgeist
aptGetRemove zeitgeist-core

# remove unwanted unity-lens
aptGetRemove unity-lens-video unity-lens-photos unity-lens-music

# remove apport
aptGetRemove apport-symptoms apport

sudo DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
