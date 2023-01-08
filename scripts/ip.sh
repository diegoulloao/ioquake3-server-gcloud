#!/bin/sh

# IP script
# @description gets the container public ip in google cloud

# load project environment variables
set -a; source .env; set +a

echo ""

# get ip from cluster
kubectl get svc $CLUSTER

echo ""
exit 0
