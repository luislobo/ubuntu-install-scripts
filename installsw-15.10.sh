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

##### INSTALL CLI PACKAGES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 

# Java
# Auto accept oracle installer license
sudo apt-get install -y oracle-java8-installer
sudo update-java-alternatives -s java-8-oracle

# Very basic Linux build tools
sudo apt-get -y install build-essential make

# ZSH, OhMyZSH, its plugins & set as default for current user
sudo apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
sed -i 's/plugins=(git)/plugins=(git command-not-found common-aliases compleat fabric mercurial npm pip python redis-cli vagrant yii)/g' ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="amuse"/g' ~/.zshrc

# Basic Common tools
sudo apt-get install -y mc htop curl ntp ntfs-config

# Compression tools
sudo apt-get install -y p7zip-full unrar

# Git and tig
sudo apt-get install -y git git-cola tig

# Mercurial
sudo apt-get install -y mercurial

# Byobu and sets byobu as an available shell
sudo apt-get install -y byobu
BYOBU_LOCATION=$(which byobu)
sudo sh -c "grep -q '$BYOBU_LOCATION' /etc/shells || echo '$BYOBU_LOCATION'>> /etc/shells"

# nvm, node and modules
bash -c "wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.30.2/install.sh"
nvm install 4.3
nvm use 4.3
nvm alias default 4.3

# NPM modules
sudo npm install -g sails bower grunt-cli pm2 mocha jshint express-generator gulp karma coffee-script dependency-check node-inspector

# Audio and Video avconv & other video tools (replaces ffmpeg)
sudo apt-get install -y ffmpeg

# Test disk (recovery tools)
sudo apt-get install -y testdisk

# iostat
sudo apt-get install -y sysstat

# iotop
sudo apt-get install -y iotop

# nethogs - View network and processes
sudo apt-get install -y nethogs

# network TOP
sudo apt-get install -y iftop

# whois
sudo apt-get install -y whois

# Install preload (speeds up stuff)
sudo apt-get install -y preload

# Enhances Notebook Batery Life
sudo apt-get install -y tlp tlp-rdw
sudo tlp start

# Nginx
sudo apt-get install -y nginx

# MongoDB
sudo apt-get install -y libkrb5-dev
sudo apt-get install -y mongodb-org

# Redis
sudo apt-get install -y redis-server

# SQLite
sudo apt-get install -y sqlite

# Memcached
sudo apt-get install -y memcached

# Encrypt FS utils
sudo apt-get install -y ecryptfs-utils

# Gnome Partition Editor
sudo apt-get install -y gparted

# Fabric tool
sudo apt-get install -y fabric

# DKMS - updates things like virtualbox when a new kernel appears
sudo apt-get install -y dkms

# Linux containers
sudo apt-get install -y lxc lxctl lxc-templates

# Better Deb installer
sudo apt-get install -y gdebi


##### GUI PACKAGES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

# Anonymous PRO font
sudo apt-get install -y ttf-anonymous-pro

# TortoiseHG
sudo apt-get install -y tortoisehg

# Meld
sudo apt-get install -y meld

# Guake
sudo apt-get install -y guake

# sets
# default shell to byobu
# rename keybinding to Shift+Ctrl+F3
# Transparency to 15
# Font to Anonymous Pro
# History size to 9999
# Start full screen to true
# Use default font false
# Tab bar false
cat >guake.xml <<EOF
<gconfentryfile>
  <entrylist base="/apps/guake">
    <entry>
      <key>general/default_shell</key>
      <schema_key>/schemas/apps/guake/general/default_shell</schema_key>
      <value>
        <string>/usr/bin/byobu</string>
      </value>
    </entry>
    <entry>
      <key>general/history_size</key>
      <schema_key>/schemas/apps/guake/general/history_size</schema_key>
      <value>
        <int>99999</int>
      </value>
    </entry>
    <entry>
      <key>general/use_default_font</key>
      <schema_key>/schemas/apps/guake/general/use_default_font</schema_key>
      <value>
        <bool>false</bool>
      </value>
    </entry>
    <entry>
      <key>general/start_fullscreen</key>
      <schema_key>/schemas/apps/guake/general/start_fullscreen</schema_key>
      <value>
        <bool>true</bool>
      </value>
    </entry>
    <entry>
      <key>keybindings/local/rename_tab</key>
      <schema_key>/schemas/apps/guake/keybindings/local/rename_tab</schema_key>
      <value>
        <string>&lt;Primary&gt;&lt;Shift&gt;F2</string>
      </value>
    </entry>
    <entry>
      <key>general/window_tabbar</key>
      <schema_key>/schemas/apps/guake/general/window_tabbar</schema_key>
      <value>
        <bool>false</bool>
      </value>
    </entry>
    <entry>
      <key>style/background/transparency</key>
      <schema_key>/schemas/apps/guake/style/background/transparency</schema_key>
      <value>
        <int>15</int>
      </value>
    </entry>
    <entry>
      <key>style/font/style</key>
      <schema_key>/schemas/apps/guake/style/font/style</schema_key>
      <value>
        <string>Liberation Mono 10</string>
      </value>
    </entry>
  </entrylist>
</gconfentryfile>
EOF
gconftool-2 --load guake.xml
rm -f guake.xml

# Virtualbox
#sudo apt-get install -y virtualbox virtualbox-guest-additions-iso

# Chrome
sudo apt-get install -y google-chrome-stable

# Unity Tweak tool
sudo apt-get install -y unity-tweak-tool

# Indicator Multiload
sudo apt-get install -y indicator-multiload

### LUIS SPECIFIC STUFF

# spotify
sudo apt-get install -y spotify-client

# zsync
sudo apt-get install -y zsync

# Screen profiles
sudo apt-get install -y arandr

# Hardware info
sudo apt-get install -y hwinfo

# Install Atom Editor
wget https://atom.io/download/deb -O atom.deb
sudo dpkg -i atom.deb
rm -y atom-deb

# MySQL
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
#sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
#sudo apt-get install -y mysql-server php5-dev php5-cli php5-gd php5-fpm php5-mcrypt php5-json php5-mysql php5-xdebug php5-geoip php5-memcached php5-xmlrpc php5-xsl

# Openvpn client
sudo apt-get install -y openvpn network-manager-openvpn

# adds keep alive to ssh session
# mkdir ~/.ssh
# touch ~/.ssh/config
# grep -q 'ServerAliveInterval' .ssh/config || sed -i '1iHost *\n\tServerAliveInterval 300\n\tServerAliveCountMax 2\n\n' ~/.ssh/config

# Better volume control (have to run it manually as it does not replace built-in)
sudo apt-get install -y pavucontrol

# WM ctrl to send messages to windows
sudo apt-get install -y wmctrl

# Samba
sudo apt-get install -y samba

# Intel drivers for Ubuntu 14.04 64 bit
#wget https://download.01.org/gfx/ubuntu/14.04/main/pool/main/i/intel-linux-graphics-installer/intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb
#sudo dpkg -i intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb
#rm intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb

# Pdf MOD
sudo apt-get install -y pdfmod

# Logitech Unified Receiver Manager
sudo apt-get install -y solaar

# Pulse audio equalizer
sudo apt-get install -y pulseaudio-equalizer

# GStreamer Plugin for wma in Clementine
sudo apt-get install -y gstreamer0.10-plugins-bad gstreamer0.10-plugins-bad-multiverse

# Compiz
sudo apt-get install -y compizconfig-settings-manager

# use compiz settings manager and change this settings
# Launcher Reveal Pressure = 3
# Launcher Edge Stop Overcome Pressure = 15
# Pressure Decay Rate = 3
# Edge Stop Velocity = 10
# Sync to VBlank = false

# Advanced volume control
sudo apt-get install -y pavucontrol

# skype
# First, libraries so that skype looks correctly on Ubuntu 64
sudo apt-get install -y gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386
sudo apt-get install -y skype

# Truecrypt
sudo apt-get install -y truecrypt

# Record my desktop
sudo apt-get install -y gtk-recordmydesktop

# Clementine
sudo apt-get install -y clementine

# VLC
sudo apt-get install -y vlc

# GIMP
sudo apt-get install -y gimp gimp-plugin-registry

# Feh
sudo apt-get install -y feh

# Wine
sudo apt-get install -y wine winetricks

# remove fonts-unfonts-core because it makes java render funny
sudo apt-get remove -y fonts-unfonts-core

# install netbeans
wget http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-html-linux-x64.sh -O latest-netbeans.sh
sudo sh latest-netbeans.sh
rm -f latest-netbeans.sh

# install exfat format. Needed for SD cards used in phones
sudo apt-get install -y exfat-fuse exfat-utils

# remove zeitgeist
sudo apt-get remove -y zeitgeist-core

# remove unwanted unity-lens
sudo apt-get remove -y unity-lens-video unity-lens-photos unity-lens-music

# remove apport
sudo apt-get remove -y apport-symptoms apport

sudo apt-get autoremove -y
