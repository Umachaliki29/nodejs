#!/bin/bash

IMAGE_TAG=$1
ECR_IMAGE="$ACCOUNT_ID.dkr.ecr.ap-southeast-1.amazonaws.com/node-hello:$IMAGE_TAG"
EC2_USER="ubuntu"
EC2_HOST="18.196.175.95"
REMOTE_APP_DIR="/home/ubuntu/nodeapp"
STACK_NAME="node-hello"

ssh -i ec2-key.pem -o StrictHostKeyChecking=no $EC2_USER@$EC2_HOST << EOF
  set -e
  mkdir -p $REMOTE_APP_DIR
  cat <<EOC > $REMOTE_APP_DIR/docker-compose.yml
version: '3.8'

services:
  web:
    image: $ECR_IMAGE
    ports:
      - "80:80"
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
EOC

  echo Deploying stack...
  docker stack deploy -c $REMOTE_APP_DIR/docker-compose.yml $STACK_NAME
EOF
