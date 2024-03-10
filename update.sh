#!/bin/bash

docker-compose down
docker-compose pull
docker-compose up --build -d
docker ps|grep audible-cli
