#!/bin/bash
#
# Purpose: Script to run SIGS deploy
#
# Notice: The deploy machine should be previously
# configured with ambient variables to perform
# all of the needed actions
#
# Author: João Pedro Sconetto <sconetto.joao@gmail.com>

echo $DOCKERHUB_PASS | docker login -u $DOCKERHUB_USER --password-stdin
docker pull projetosigs/sigs-gces:latest
docker-compose -f /home/sigs/SIGS-GCES/docker-compose-dev.yml pull --include-deps db
docker-compose -f /home/sigs/SIGS-GCES/docker-compose-dev.yml up -d
docker logout
rm -r /home/sigs/.docker/config.json