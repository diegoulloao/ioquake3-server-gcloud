# ioquake3-server-gcloud

## Prerequisites

1. Google Cloud account
2. Google Cloud CLI installed and configured
3. Docker
4. Git

[Read more](https://github.com/diegoulloao/ioquake3-server-gcloud/tree/main/docs/prerequisites.md)

## Deploying to Google Cloud

Deploying to Google Cloud is pretty simple, just follow the next steps:

1. Copy the `pak[0-8].pk3` dependencies inside the `lib/baseq3` folder _(optional)_ or skip this step and let the script download them for you.

2. Copy the `.env.example` -> `.env` and add the project and cluster environment vars from google cloud _(required)_.

Example `.env`:

```bash
# project
PROJECT_ID=norse-lotus-3621XX
CONTAINER_IMAGE=quake3:latest

# cluster specific
CLUSTER=quake3-cluster-1
ZONE=us-central-1
```

3. Run the deploy:

```bash
./deploy.sh
```

In a couple of seconds your server should be online to play:

```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)           AGE
quake3   LoadBalancer   11.104.2.XXX   35.172.21.XXX   27960:32108/UDP   0s
```

## Local testing

1. Download the `.pk3` dependencies _(optional)_:

```bash
./prepare.sh
```

or just copy the `pak[0-8].pk3` files inside the `lib/baseq3` folder.

2. Build the Docker image:

```bash
docker build -t quake3 .
```

3. Run the server:

```bash
docker run -p 27960:27960/udp -it quake3
```

You should be able to find the running server inside the local tab in the quake3 multiplayer section or just connecting to localhost.

## Troubleshooting

- Permission denied when running the scripts:

```bash
chmod 755 deploy.sh prepare.sh
```

---

**diegoulloao · 2022**
