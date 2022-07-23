#!/bin/bash

# Run fresh minikube with extra config to allow for port forwarding to keep going
minikube delete
minikube start --extra-config=kubelet.streaming-connection-idle-timeout=0

# Enable the Ingress addon
minikube addons enable ingress

# Setup traefik
for filename in *.yaml; do
  kubectl apply -f "$filename"
done

# Allow users to bind lower ports (specifically 443)
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/bin/kubectl

# Set kubernetes port forwarding service
mkdir -p ~/.config/systemd/user
cp ./kubepf.service ~/.config/systemd/user
systemctl --user enable kubepf
systemctl --user start kubepf