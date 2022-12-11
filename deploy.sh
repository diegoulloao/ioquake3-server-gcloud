#!/bin/sh

# Deploy script
# file in charge to deploy the container into kubernetes to Google Cloud

# load project environment variables
set -a; source .env; set +a

# current working dir
CURRENT_DIR="$(dirname "$0")"

# ----------------------------------------------

# check that environment variables are not empty
if [ -z "$PROJECT_ID" ] || [ -z "$CONTAINER_IMAGE" ] || [ -z "$CLUSTER" ] || [ -z "$ZONE" ]; then
  echo "\n\033[0;31mPlease check that your .env file contains all the env vars setted.\033[0m"
  exit 1
fi

# get latest commit hash or timestamp depending of the script parameters
HASH=$([ ! -z "$1" ] && [ "$1" == "-a" ] && \
  echo $(date +%s) || echo $(git log --pretty=format:'%h' -n 1) \
)

# sync dependencies
source $CURRENT_DIR/prepare.sh

# deploying user feedback message
echo "\nDeploying to Google Cloud...\n"

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

# copy of deployment.yaml replacing the environment vars
sed -e "s/\${HASH}/$HASH/; \
  s/\${PROJECT_ID}/$PROJECT_ID/; \
  s/\${CONTAINER_IMAGE}/$CONTAINER_IMAGE/" \
deployment.yaml > .deployment.tmp.yaml

# apply copy of deployment.yaml with environment vars and hash inside
kubectl apply -f .deployment.tmp.yaml

# apply services
kubectl apply -f services.yaml

# delete copy of deployment.yaml
rm .deployment.tmp.yaml

# deploy completed user feedback
echo "\n\033[1;32mDeploy completed.\033[0m\n"

# print cluster info
kubectl get svc quake3

exit 0
