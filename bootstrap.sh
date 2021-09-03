#!/bin/bash
# Script deploy nextcloud with docker-compose

##########################################################################################
# SECTION 1: PREPARE

# change root
sudo -i
sleep 2

# update system
# yum clean all
# yum -y update
# sleep 1

# config timezone
timedatectl set-timezone Asia/Ho_Chi_Minh

# disable SELINUX
setenforce 0 
sed -i 's/enforcing/disabled/g' /etc/selinux/config

# disable firewall
systemctl stop firewalld
systemctl disable firewalld

# config hostname
hostnamectl set-hostname docker1

# config file host
cat >> "/etc/hosts" <<END
 172.20.10.10 docker1 docker1.hit.local
END

##########################################################################################
# SECTION 2: INSTALL Docker, Docker-compse, git
# Install docker
curl -fsSL https://get.docker.com/ | sh
systemctl start docker
systemctl enable docker

# Install docker-compose
sudo curl -sL "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install git
yum -y install git

#########################################################################################
# SECTION 3: DEPLOY nextcloud

# make directory nextcloud
cd ~
mkdir -p /home/nextcloud

# clone repo
cd /home/nextcloud
git clone https://github.com/hieunt84/play-docker.git
cd ./play-docker/3-docker-compose/

# run docker-compose
docker-compose up -d

# verify
docker-compose ps
  
#########################################################################################
# SECTION 4: FINISHED

# config firwall
systemctl start firewalld
systemctl enable firewalld
sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
# Open Port for link Portainer
sudo firewall-cmd --zone=public --permanent --add-port=2375/tcp
sudo firewall-cmd --reload
sudo systemctl restart firewalld

# notification
echo " DEPLOY COMPLETELY"