#!/bin/bash

# load project environment variables
set -a; source .env; set +a

# image name
export IMAGE_NAME=quake3

# ----------------------------------

# authentication
gcloud config set project $PROJECT_ID

# build docker image (linux arm64 specific)
docker build --platform=linux/amd64 -t $IMAGE_NAME .

# upload image to the cloud register
gcloud auth configure-docker
docker tag $CONTAINER_IMAGE gcr.io/$PROJECT_ID/$CONTAINER_IMAGE
docker push gcr.io/$PROJECT_ID/$CONTAINER_IMAGE

# connect to k8s to install image
gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT_ID

# install
kubectl apply -f deployment.yaml
kubectl apply -f services.yaml

# print clusters info
kubectl get svc $IMAGE_NAME
