#!/bin/sh

# Create script
# @description creates the cluster for the container in google cloud

# load project environment variables
set -a; source .env; set +a

# exit on error
set -e

# start time
start_time=$(date +%s)

# user feedback output
echo "\n\033[0;36mCreating cluster $CLUSTER in google cloud... [average time: 9min]\033[0m\n"

# create cluster in google cloud
gcloud container clusters create-auto $CLUSTER --region $ZONE --project=$PROJECT_ID

# success user feedback output
echo "\n\033[1;32mCluster $CLUSTER created ✓\033[0m"

# end time
end_time=$(date +%s)

# runtime calculation
runtime=$((end_time - start_time))

# task time output
echo "\033[0;36mTime elapsed: $(((runtime % 3600) / 60))min $(((runtime % 3600) % 60))seg\033[0m\n"
