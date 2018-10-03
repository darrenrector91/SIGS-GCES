#!/bin/bash
#
# Purpose: Continuous deploy on production environment
#
# Author: João Pedro Sconetto <sconetto.joao@gmail.com>
# Author: Arthur Diniz <arthurbdiniz@gmail.com>

docker-compose -f ../docker-compose-prod.yml up --build -d
docker tag sigsgces_web $DOCKERHUB_USER/sigs-gces:stable
docker push $DOCKERHUB_USER/sigs-gces:stable

sudo apt-get install sshpass -y
# Production machine isn't available yet
sshpass -p $SSH_PASSWORD ssh $SSH_USER@0.0.0.0 '/bin/bash /home/sigs/SIGS-GCES/script/deploy.sh