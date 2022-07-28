#!/bin/bash

# Run fresh minikube with extra config to allow for port forwarding to keep going
minikube delete
minikube start

# Enable the Ingress addon
minikube addons enable ingress

# Setup traefik
for filename in *.yaml; do
  kubectl apply -f "$filename"
done

# TODO : run "minikube tunnel"
# TODO : create a service for the minikube tunnel
# TODO : check if route is 10.96.0.0/12 on a fresh install
# TODO : add external ip 10.96.184.178 (used in nginx.conf) to service/traefik

# Port forward
sudo apt-get install -y nginx
sudo cat nginx.conf >> /etc/nginx/nginx.conf
sudo service nginx restart