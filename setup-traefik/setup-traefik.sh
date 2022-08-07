#!/bin/bash

mkdir /home/debian/data

# Run fresh minikube with extra config to allow for port forwarding to keep going
minikube delete
minikube start --hyperv-virtual-switch "My Virtual Switch" --v=4 --mount --mount-string="/home/debian/data/:/data/"

# Enable the Ingress addon
minikube addons enable ingress

# Setup traefik
for filename in *.yaml; do
  kubectl apply -f "$filename"
done

# Create minikube-tunnel service
mkdir -p ~/.config/systemd/user
cp ./minikube-tunnel.service ~/.config/systemd/user
systemctl --user enable minikube-tunnel
systemctl --user start minikube-tunnel

# Port forward
sudo apt-get install -y nginx
cat nginx.conf | sudo tee -a /etc/nginx/nginx.conf
cat nginx-default.conf | sudo tee /etc/nginx/sites-enabled/default
sudo service nginx restart