#!/bin/bash

kubectl create ns argocd

# https://raw.githubusercontent.com/argoproj/argo-cd/v2.0.1/manifests/install.yaml
kubectl apply -n argocd -f install.yaml

# give myself cluster admin role
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user="$(gcloud config get-value account)"

# apps
find ./applications -name \*.yaml -exec kubectl apply -f {} \;

# TODO:
echo "After logging in run: `argocd repo add https://charts.bitnami.com/bitnami --type=helm --name bitnami`
