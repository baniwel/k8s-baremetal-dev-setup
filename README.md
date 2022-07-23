# Bare metal Development Kubernetes Cluster

The goal of the projet is the setup a fast minikube cluster where apps are externally exposed. 
In order expose the apps we use traefik as a proxy.

_PS: Kubernetes files are taken from https://doc.traefik.io/traefik/user-guides/crd-acme/ which an **excellent** tutorial._

In order for everything to run smoothly, I run these scripts on a fresh install. My tests were run on a Debian 11 bare metal virtual machine.

## 1- Minikube setup
Run `./setup-minikube/setup-minikube.sh`

This script will:
1. Install **minikube**
2. Install **Docker**
3. Setup aliases
   1. `kc` for `kubectl`
   2. `kca` for `kubectl apply -f`
4. Setup autocompletion for kubectl and minikube

## 2- Traefik setup
Run `./setup-traefik/setup-traefik.sh`

This script will:
1. Setup a fresh minikube cluster
2. Install traefik on the cluster by applying the kubernetes .yaml files under **_setup-traefik_**
3. **!! Elevate kubectl and allow the binary to bind low level ports (needed for port 443 binding) !!**
4. Creates and runs a systemd service **kubepf** that will port forward ports between the cluster and the machine

## 3- Examples
Under **_examples_**, you can find examples of apps to run.

|    Resources    | Application |              Changes needed               |
|:---------------:|:-----------:|:-----------------------------------------:|
| examples/whoami |   whoami    | Replace the host in the ingress.yaml file |