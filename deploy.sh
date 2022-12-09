#!/bin/bash

# project
export PROJECT_ID=neat-spark-277400
export CONTAINER_IMAGE=quake3:latest

# cloud specific
export CLUSTER=cluster-1
export ZONE=us-central1-c

# ----------------------------------

# authentication
gcloud config set project $PROJECT_ID

# build docker image
docker build -t quake3 .

# upload image to the cloud register
gcloud auth configure-docker
docker tag $CONTAINER_IMAGE gcr.io/$PROJECT_ID/$CONTAINER_IMAGE
docker push gcr.io/$PROJECT_ID/$CONTAINER_IMAGE

# connect to k8s to install image
gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT_ID

# install
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml

# print info
kubectl get svc
