# This script still requires user to be created on the hostname, please replace or provide ${username} 
# This script was used on AWS EC2 instances, to ensure fairly smooth experience it requires 4GB RAM so choose t2/3.medium or equivalent or assign 4GB per node if using locally with i.e VirtualBox

#!/bin/bash

#UPDATES
sudo apt-get upgrade

sudo apt-get update

#DOCKER

mkdir /home/docker

cd /home/docker

sudo apt install apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt update

apt-cache policy docker-ce

sudo apt install docker-ce

#K8S

mkdir /home/k8s

cd /home/k8s

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"

echo "$(<kubectl.sha256)  kubectl" | sha256sum --check

sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

chmod +x kubectl
mkdir -p ~/.local/bin/kubectl
mv ./kubectl ~/.local/bin/kubectl

