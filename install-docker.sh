#! /usr/bin/env bash
sudo yum update -y
sudo amazon-linux-extras install -y docker
sudo service docker start
sudo usermod -a -G docker ec2-user

sudo docker swarm init
sudo docker stack deploy -c /home/ec2-user/docker-compose.yml webapp_service
