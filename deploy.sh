#!/bin/sh

# Deploy script
# file in charge to deploy the container into kubernetes to Google Cloud

# load project environment variables
set -a; source .env; set +a

# ----------------------------------

# get last commit hash
COMMIT_HASH=$(git log --pretty=format:'%h' -n 1)

# authentication
gcloud config set project $PROJECT_ID

# build docker image (linux arm64 specific)
docker build --platform=linux/amd64 -t quake3 .

# upload image to the cloud register
gcloud auth configure-docker
docker tag $CONTAINER_IMAGE gcr.io/$PROJECT_ID/$CONTAINER_IMAGE
docker push gcr.io/$PROJECT_ID/$CONTAINER_IMAGE

# connect to k8s to install image
gcloud container clusters get-credentials $CLUSTER --zone $ZONE --project $PROJECT_ID

# copy of deployment.yaml replacing the hash value
sed -e "s/\${COMMIT_HASH}/$COMMIT_HASH/; \
  s/\${PROJECT_ID}/$PROJECT_ID/; \
  s/\${CONTAINER_IMAGE}/$CONTAINER_IMAGE/" \
deployment.yaml > .deployment.tmp.yaml

# apply copy of deployment.yaml with commit hash inside
kubectl apply -f .deployment.tmp.yaml

# apply services
kubectl apply -f services.yaml

# delete copy of deployment.yaml
rm .deployment.tmp.yaml

# print cluster info
kubectl get svc quake3

exit 0
