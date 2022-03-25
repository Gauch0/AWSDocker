#!/bin/sh

# export myip=192.168.71.128
export myip=$(curl -s ifconfig.me)


#MYSQL 

export MYSQL_ROOT_PASSWORD=laralara

export HOST_PORT=3306

export CONTAINER_NAME=bbdd

export MYSQL_DATABASE=movie_db


#API

export DB_HOST=$myip

export DB_USER=root
 
export DB_PASS=laralara

export DB_NAME=movie_db

#UI

export BACKEND_URL=$myip