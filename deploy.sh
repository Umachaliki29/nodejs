#!/bin/bash

# Variables - update these accordingly
GITHUB_RAW_URL="https://github.com/Umachaliki29/nodejs/blob/main/Dockercompose.yml"

AWS_REGION="us-east-1"
AWS_ACCOUNT_ID="471112907169"
STACK_NAME="nodeapp-stack"

echo "Step 1: Downloading latest docker-compose.yml from GitHub..."
curl -o docker-compose.yml $GITHUB_RAW_URL

if [ $? -ne 0 ]; then
  echo "Failed to download docker-compose.yml. Exiting."
  exit 1
fi

echo "Step 2: Logging into AWS ECR..."
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com

if [ $? -ne 0 ]; then
  echo "AWS ECR login failed. Exiting."
  exit 1
fi

echo "Step 3: Deploying Docker stack..."
docker stack deploy -c docker-compose.yml $STACK_NAME

if [ $? -eq 0 ]; then
  echo "Docker stack deployed successfully."
else
  echo "Docker stack deployment failed."
  exit 1
fi
