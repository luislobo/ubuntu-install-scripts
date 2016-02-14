sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

# python-software-properties installs add-apt-repository
sudo apt-get install -y python-software-properties

##### REPOSITORIES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 

# Git
sudo add-apt-repository -y ppa:git-core/ppa

# Java 8
sudo add-apt-repository -y ppa:webupd8team/java

# Chrome
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'

# Nginx
sudo add-apt-repository -y ppa:nginx/development

# MongoDB 3.2
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.2 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list

### SPECIFIC STUFF LUIS USES

# spotify
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

# Intel graphics card key
# sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A902DDA375E52366

# Various, in specific, truecrypt
sudo add-apt-repository -y ppa:stefansundin/truecrypt

# Clementine
sudo add-apt-repository -y ppa:me-davidsansome/clementine-dev

# Equalizer
sudo add-apt-repository -y ppa:nilarimogard/webupd8

# Libre Office
sudo add-apt-repository -y ppa:libreoffice/ppa

# Wine
sudo add-apt-repository -y ppa:ubuntu-wine/ppa

##### UPDATE REPOSITORIES ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### ##### 
sudo apt-get update
