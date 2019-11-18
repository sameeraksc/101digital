#!/bin/bash

kubectl apply -f /home/centos/kubedashboard/kubernetes-dashboard.yaml

kubectl create serviceaccount dashboard -n default

kubectl create clusterrolebinding dashboard-admin -n default  --clusterrole=cluster-admin  --serviceaccount=default:dashboard
echo ""
echo "**************start of the token**************"

kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode

echo "**************** end of the token************"
