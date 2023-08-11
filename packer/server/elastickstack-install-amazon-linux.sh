#!/bin/bash
# 
# user-data script for deploying Elasticstack on Amazon Linux 2
# 
#  

# Update system and install dependencies
sudo yum update -y

# Install docker
sudo amazon-linux-extras install docker -y
sudo yum install docker -y
sudo systemctl restart docker
sudo systemctl enable docker

# Set up volumes
sudo mkdir /data /data/mysql /data/certs /data/prometheus /data/templates
sudo chown root -R /data

# Setting vm.max_map_count=262144
echo vm.max_map_count=262144 |sudo tee -a /etc/sysctl.conf