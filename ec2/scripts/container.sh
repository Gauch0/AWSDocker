#!/bin/sh

docker run -it --rm --name ${CONTAINER_NAME} -p ${HOST_PORT}:3306 -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD -e MYSQL_DATABASE=movie_db -d gauch0/r-bbdd

docker run -d --name api -p 3000:3000 -e DB_HOST=$DB_HOST -e DB_USER=$DB_USER -e DB_PASS=$DB_PASS -e DB_NAME=$DB_NAME -d gauch0/r-api

docker run -d --name ui -p 80:8000 -e BACKEND_URL=$BACKEND_URL:3000 -d gauch0/r-ui
