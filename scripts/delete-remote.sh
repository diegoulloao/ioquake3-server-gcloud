#!/bin/sh

# Delete script
# @description deletes the cluster for the container in google cloud

# load project environment variables
set -a; source .env; set +a

# exit on error
set -e

# start time
start_time=$(date +%s)

# user feedback output
echo "\n\033[0;36m
******************************************************************************
        Deleting Cluster $CLUSTER from Google Cloud ... [average time: 7min]
******************************************************************************
\033[0m"

# delete cluster from google cloud
gcloud container clusters delete $CLUSTER --region $ZONE

# sucess output message
echo "\n\033[0;31mCluster $CLUSTER deleted ✓\033[0m"

# end time
end_time=$(date +%s)

# runtime calculation
runtime=$((end_time - start_time))

# task time output
echo "\033[0;36mElapsed time: $(((runtime % 3600) / 60))min $(((runtime % 3600) % 60))seg\033[0m\n"
