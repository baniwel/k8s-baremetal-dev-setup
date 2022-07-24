#!/bin/bash

# Execute files in order
for filename in *.sh; do
        sh $filename
done

# Alias preferences
echo 'alias l="ls -la"' >>~/.bashrc
echo 'alias kc="kubectl"' >>~/.bashrc
echo 'alias kca="kubectl apply -f"' >>~/.bashrc

# Setup autocompletions
echo "$(minikube completion bash)" >>~/.bashrc
echo "eval \"$(kubectl completion bash)\"" >>~/.bashrc

source ~/.profile