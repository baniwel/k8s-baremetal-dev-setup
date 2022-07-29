#!/bin/bash

# Alias preferences
echo 'alias l="ls -la"' >>~/.bashrc
echo 'alias kc="kubectl"' >>~/.bashrc
echo 'alias kca="kubectl apply -f"' >>~/.bashrc

# Execute files in order
for filename in *.sh; do
        sh $filename
done

# Setup autocompletions
echo 'source <(kubectl completion bash)' >>~/.bashrc
echo 'source <(minikube completion bash)' >>~/.bashrc

source ~/.profile