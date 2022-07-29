#!/bin/bash
echo "apt-get update"
sudo apt-get update > /dev/null

echo "Install dependencies"
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release > /dev/null

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "apt-get update"
sudo apt-get update > /dev/null

echo "Install docker"
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null

# Permettre à minikube de lancer le driver local pas en mode root
sudo chmod 666 /var/run/docker.sock
sudo usermod -aG docker $USER && newgrp docker

docker version