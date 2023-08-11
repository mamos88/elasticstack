#!/bin/bash

docker build -t $1 .
docker rm -f $1
docker run -it --name $1 -p 9200:9200 -p 9300:9300 -e "ELASTIC_PASSWORD=password123!" $1
