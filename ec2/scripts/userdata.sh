#!/bin/bash -v

#UPDATE

sudo apt-get upgrade
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl tree

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl

# INSTALL DOCKER
curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker ubuntu
sudo systemctl enable docker
cat <<EOF >/etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

#INSTALL K8S
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF >/tmp/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo mv /tmp/kubernetes.list /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
sudo systemctl enable kubelet
sudo kubeadm config images pull

#INSTALL MYSQL 

sudo apt-get update
mkdir /home/mysql
cd /home/mysql
sudo apt install mysql-server
sudo mysql_secure_installation

#GIT CLONE

mkdir /home/rampup
cd /home/rampup
sudo git clone https://github.com/Gauch0/AWSDocker.git k8s-docker-movieapi-movieui
sudo chown -R rampup k8s-docker-movieapi-movieui


sudo chmod 666 /var/run/docker.sock

#DOCKER CONTAINER
docker pull gauch0/movieapi
docker pull gauch0/movieui

docker run -d --name ui -p 80:8000 gauch0/movieui
docker run -d --name api -p 3000:3000 gauch0/movieapi




