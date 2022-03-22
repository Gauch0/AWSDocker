#!/bin/bash -v

# UPDATE

# sudo apt-get upgrade
# sudo apt-get update
# sudo apt-get install -y apt-transport-https ca-certificates curl tree

# sudo apt-get update
# sudo apt-get install -y apt-transport-https ca-certificates curl

# # INSTALL DOCKER
# curl gnupg-agent software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt-get update
# sudo apt-get install -y docker-ce docker-ce-cli containerd.io
# sudo usermod -a -G docker ubuntu
# sudo systemctl enable docker
# cat <<EOF >/etc/docker/daemon.json
# {
#   "exec-opts": ["native.cgroupdriver=systemd"],
#   "log-driver": "json-file",
#   "log-opts": {
#     "max-size": "100m"
#   },
#   "storage-driver": "overlay2"
# }
# EOF
# sudo systemctl daemon-reload
# sudo systemctl restart docker

# #INSTALL K8S
# curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
# cat <<EOF >/tmp/kubernetes.list
# deb https://apt.kubernetes.io/ kubernetes-xenial main
# EOF
# sudo mv /tmp/kubernetes.list /etc/apt/sources.list.d/kubernetes.list
# sudo apt-get update
# sudo apt-get install -y kubelet kubeadm kubectl
# echo "net.bridge.bridge-nf-call-iptables=1" | sudo tee -a /etc/sysctl.conf
# sudo sysctl -p
# sudo systemctl enable kubelet
# sudo kubeadm config images pull


# GIT CLONE

# mkdir /home/rampup
# cd /home/rampup
# sudo git clone https://github.com/Gauch0/AWSDocker.git k8s-docker-movieapi-movieui
# sudo chown -R rampup k8s-docker-movieapi-movieui


sudo chmod 666 /var/run/docker.sock


# myip=$(curl -s ifconfig.me)
myip=192.168.71.128

#MYSQL 

export MYSQL_ROOT_PASSWORD=laralara

export HOST_PORT=3306

export CONTAINER_NAME=bbdd


#API

export DB_HOST=$myip

export DB_USER=root
 
export DB_PASS=laralara

export DB_NAME=movie_db

#UI

export BACKEND_URL=$myip:3000

# -v /home/mnl/Documents/AWSDocker/movie-analyst-database:/databasedata 

#RUN CONTAINERS

docker run -it --rm --name ${CONTAINER_NAME} -p ${HOST_PORT}:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=movie_db -d mysql

docker run -d --name api -p 3000:3000 -e DB_HOST=$DB_HOST -e DB_USER=$DB_USER -e DB_PASS=$DB_PASS -e DB_NAME=$DB_NAME -d gauch0/r-api

docker run -d --name ui -p 80:8000 -e BACKEND_URL=$BACKEND_URL -d gauch0/r-ui
 
cd /home/mnl/Documents/AWSDocker/movie-analyst-database/

sudo service mysql start

docker cp ./scheme.sql bbdd:/docker-entrypoint-initdb.d/
mysql -u root -plaralara < scheme.sql

docker cp ./data.sql bbdd:/docker-entrypoint-initdb.d/
mysql -u root -plaralara < data.sql

# chmod +x docker-entrypoint.sh

# mysql -u root -p$MYSQL_ROOT_PASSWORD movie_db < /home/mnl/Documents/AWSDocker/movie-analyst-database/scheme.sql

# docker exec -i bbdd mysql -uroot -plaralara movie_db < scheme.sql
# docker exec -i bbdd mysql -uroot -plaralara movie_db < data.sql
