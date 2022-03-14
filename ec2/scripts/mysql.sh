#!/bin/bash -v

#UPDATE
sudo apt-get update
mkdir /home/mysql
cd /home/mysql
sudo apt install mysql-server
sudo mysql_secure_installation