#!/bin/bash

# Build phase
echo "Please enter Docker Hub username:"
read user_DH
echo "Please enter Docker Hub password:"
read -s pass_DH

# Build Node.js application image
sudo docker build -t my_nodejs_app:latest nodejs/
sudo docker tag my_nodejs_app $user_DH/my_nodejs_app

# Build MongoDB image
chmod +x mongo/init-data.sh
sudo docker build -t my_mongo:latest mongo/
sudo docker tag my_mongo $user_DH/my_mongo

# Deliver phase
echo $pass_DH | sudo docker login -u $user_DH --password-stdin
sudo docker push $user_DH/my_nodejs_app:latest
sudo docker push $user_DH/my_mongo:latest

#deploy
sed "s/\${user_DH}/$user_DH/g" docker-compose.yaml > ./tf/docker-compose.yaml
cd tf
terraform init
terraform apply -auto-approve
