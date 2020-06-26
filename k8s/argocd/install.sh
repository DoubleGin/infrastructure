#!/bin/bash

kubectl create ns argocd
# https://raw.githubusercontent.com/argoproj/argo-cd/v1.6.1/manifests/install.yaml
kubectl apply -n argocd -f install.yaml

# give myself cluster admin role
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin --user="$(gcloud config get-value account)"
