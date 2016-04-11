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

# https://www.vagrantup.com/downloads.html
vagrant_deb="https://releases.hashicorp.com/vagrant/1.8.1/vagrant_1.8.1_x86_64.deb"

# https://github.com/creationix/nvm#install-script
nvm_url="https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh"

# https://github.com/robbyrussell/oh-my-zsh#via-wget
oh_my_zsh_url="https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh"

# https://netbeans.org/downloads/start.html?platform=linux&lang=en&option=html&bits=x64
netbeans_url="http://download.netbeans.org/netbeans/8.1/final/bundles/netbeans-8.1-html-linux-x64.sh"

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


# Java
# remove old java
aptGetRemove openjdk-7-jre default-jre openjdk-7-jre default-jre-headless openjdk-7-jre-headless

# Auto accept oracle installer license
echo debconf shared/accepted-oracle-license-v1-1 select true | \
  sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  sudo debconf-set-selections

aptGetInstall oracle-java8-installer oracle-java8-set-default
#sudo update-java-alternatives -s java-8-oracle

# Very basic Linux build tools
aptGetInstall build-essential make

# ZSH, OhMyZSH, its plugins & set as default for current user
aptGetInstall zsh
sh -c "$(wget $oh_my_zsh_url -O -)"
sed -i 's/plugins=(git)/plugins=(aws bower command-not-found composer common-aliases compleat debian dircycle dirhistory dirpersist docker gitfast git-extras fabric last-working-dir mercurial node npm pip python redis-cli screen sublime sudo systemd vagrant web-search yii yii2 wd)/g' ~/.zshrc
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="amuse"/g' ~/.zshrc

# Basic Common tools
aptGetInstall mc htop curl ntp ntfs-config

# Compression tools
aptGetInstall p7zip-full unrar

# Git and tig
aptGetInstall git git-cola tig

# Mercurial
aptGetInstall mercurial

# Byobu and sets byobu as an available shell
aptGetInstall byobu
BYOBU_LOCATION=$(which byobu)
sudo sh -c "grep -q '$BYOBU_LOCATION' /etc/shells || echo '$BYOBU_LOCATION'>> /etc/shells"

# nvm, node and modules
bash <(wget -qO- $nvm_url)
export NVM_DIR="$HOME/.nvm"
echo $NVM_DIR
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
nvm install 4
nvm use 4
nvm alias default 4
which node
which npm
node --version
npm --version
npm install npm@latest -g
npm --version

# NPM modules
npm install -g sails bower grunt-cli pm2 mocha jshint express-generator gulp karma coffee-script dependency-check node-inspector npm-check-updates bower-check-updates

# Audio and Video avconv & other video tools (replaces ffmpeg)
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

# MariaDB
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password password PASS'
sudo debconf-set-selections <<< 'mariadb-server-10.0 mysql-server/root_password_again password PASS'
aptGetInstall mariadb-server
mysql -uroot -pPASS -e "SET PASSWORD = PASSWORD('123');"

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

# Linux containers
aptGetInstall lxc lxctl lxc-templates

# Vagrant
sudo installFromUrl $vagrant_deb

# Better Deb installer
aptGetInstall gdebi

##### GUI PACKAGES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### #####

# Anonymous PRO font
aptGetInstall ttf-anonymous-pro

# TortoiseHG
aptGetInstall tortoisehg

# Meld
aptGetInstall meld

# Guake
aptGetInstall guake

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

# adds keep alive to ssh session
# mkdir ~/.ssh
# touch ~/.ssh/config
# grep -q 'ServerAliveInterval' .ssh/config || sed -i '1iHost *\n\tServerAliveInterval 300\n\tServerAliveCountMax 2\n\n' ~/.ssh/config

# Better volume control (have to run it manually as it does not replace built-in)
aptGetInstall pavucontrol

# WM ctrl to send messages to windows
aptGetInstall wmctrl

# Samba
aptGetInstall samba

# Intel drivers for Ubuntu 14.04 64 bit
#wget https://download.01.org/gfx/ubuntu/14.04/main/pool/main/i/intel-linux-graphics-installer/intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb
#sudo dpkg -i intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb
#rm intel-linux-graphics-installer_1.0.5-0intel1_amd64.deb

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
aptGetInstall gtk2-engines-murrine:i386 gtk2-engines-pixbuf:i386
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

# remove fonts-unfonts-core because it makes java render funny
aptGetRemove -y fonts-unfonts-core

# install netbeans
wget $netbeans_url -O latest-netbeans.sh
sudo sh latest-netbeans.sh
rm -f latest-netbeans.sh

# install exfat format. Needed for SD cards used in phones
aptGetInstall exfat-fuse exfat-utils

# remove zeitgeist
aptGetRemove zeitgeist-core

# remove unwanted unity-lens
aptGetRemove unity-lens-video unity-lens-photos unity-lens-music

# remove apport
aptGetRemove apport-symptoms apport

sudo DEBIAN_FRONTEND=noninteractive apt-get autoremove -y
