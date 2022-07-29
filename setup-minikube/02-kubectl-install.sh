#!/bin/bash
echo "Install dependencies"
sudo apt-get update && sudo apt-get install -y apt-transport-https > /dev/null

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

echo "Install kubectl"
sudo apt-get update
sudo apt-get install -y kubectl > /dev/null

echo "Link kube"
sudo ln -s /usr/bin/kubectl /usr/local/bin/kubectl