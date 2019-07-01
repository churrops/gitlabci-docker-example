#!/bin/bash

mkdir -p gitlab/config gitlab/logs gitlab/data
mkdir -p gitlab-runner/config

docker pull gitlab/gitlab-ce:12.0.2-ce.0
docker pull gitlab/gitlab-runner:v12.0.1

docker-compose up -d

sleep 10

GITLAB_IP=$(docker container inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' gitlab)

docker exec -it runner \
  
gitlab-runner register -n \
   --url http://gitlab.docker/ \
   --registration-token zUdbcsbxUMW-zcLFSnaV \
   --executor docker \
   --description "My Docker Runner" \
   --docker-image "docker:stable" \
   --docker-privileged
