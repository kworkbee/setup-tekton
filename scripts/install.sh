#!/bin/sh
###################
## Prerequisites ##
###################
# minikube
# cri-tools

# 1. Start local cluster (using minikube)
minikube start --kubernetes-version=v1.24.0 --force-systemd

# 2. Check minikube cluster started
kubectl cluster-info

# 3. Install Tekton Pipeline
TEKTON_PIPELINE_VERSION=v0.41.1
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/previous/$TEKTON_PIPELINE_VERSION/release.yaml

# 4. Check whether Tekton Ready
kubectl -n tekton-pipelines wait --for=condition=Ready --timeout=1200s -l app=tekton-pipelines-controller pods

# 5. Label
kubectl label --overwrite ns tekton-pipelines pod-security.kubernetes.io/enforce=privileged

# 7. Install Tekton Triggers
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/release.yaml
kubectl apply --filename https://storage.googleapis.com/tekton-releases/triggers/latest/interceptors.yaml
