kubectl apply --filename https://storage.googleapis.com/tekton-releases/dashboard/latest/release-full.yaml
kubectl -n tekton-pipelines wait --for=condition=Ready --timeout=30s -l app=tekton-dashboard pods
kubectl --namespace tekton-pipelines port-forward svc/tekton-dashboard 9097:9097 &