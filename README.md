# Bare metal Development Kubernetes Cluster

The goal of the projet is to setup a fast minikube cluster where apps are externally exposed. 
In order to expose the apps, we use traefik as a proxy.

_PS: Kubernetes files are taken from https://doc.traefik.io/traefik/user-guides/crd-acme/ which is an **excellent** documentation/tutorial._

In order for everything to run smoothly, I run these scripts on a fresh install.

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
3. Creates and runs a systemd service **minikube-tunnel** that will create a minikube tunnel to allow redirecting to kubernetes pods
4. Install nginx et set configs for redirection to the cluster when hitting both ports 80 and 443
PS: All port 80 connections are redirected to the cluster, rules must be added if you're nginx is being used for other purposes.

## 3- Examples
Under **_examples_**, you can find examples of apps to run.

|    Resources    | Application |              Changes needed               |
|:---------------:|:-----------:|:-----------------------------------------:|
| examples/whoami |   whoami    | Replace the host in the ingress.yaml file |

---

I ran these scripts on:
- Debian 11
- Kubernetes client: v1.24.3
- Kubernetes server: v1.24.1
- minikube: v1.26.0
- Docker: 20.10.17