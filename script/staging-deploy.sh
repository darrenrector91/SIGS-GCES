#!/bin/bash
#
# Purpose: Continuous deploy on staging environment
#
# Author: João Pedro Sconetto <sconetto.joao@gmail.com>
# Author: Arthur Diniz <arthurbdiniz@gmail.com>

docker tag sigs-gces_web $DOCKERHUB_USER/sigs-gces:latest
docker push $DOCKERHUB_USER/sigs-gces:latest
