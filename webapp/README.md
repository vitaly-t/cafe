# Arkadia Cafe Webapp
API and frontend for Arkadia Cafe

## Overview

TODO

## Installation and Configuration

### Install This Repo 

Clone this Git repository to your local disk on target machine.

```
cd ~
git clone https://github.com/...
```

### Download and install nodejs and dependencies

```
adduser nodejs # specify some password if asked to
passwd nodejs -d # delete password if given above
su - nodejs
wget https://nodejs.org/dist/v4.4.7/node-v4.4.7-linux-x64.tar.gz
tar --strip-components 1 -xzf node-v4.4.7-linux-x64.tar.gz
npm install -g express
npm install -g express-generator
```

# Install the cafe service 

```
cp cafe/webapp/cafeservice /etc/init.d/
chmod 755 /etc/init.d/cafeservice
chkconfig --add cafeservice # on fedora based systems
chkconfig cafeservice on # on fedora based systems
update-rc.d cafeservice defaults # on ubuntu
service cafeservice start
```
