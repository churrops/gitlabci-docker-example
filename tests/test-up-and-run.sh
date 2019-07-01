#!/bin/sh

docker run -d --name nginx -p 80:80 nginx:teste1 curl localhost
docker rm -f nginx
