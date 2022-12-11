<p align="right">
  <img src="https://img.shields.io/badge/ioquake3-server-red?style=for-the-badge" />
</p>

<p align="center">
  <img src="https://github.com/diegoulloao/ioquake3-mac-install/raw/master/logo.png" alt="ioQuake3 Arena" width="560"/>
</p>

---

<p align="center">
  <b><a href="https://github.com/diegoulloao/ioquake3-server-gcloud">The fastest way to create your own quake3 server using Google Cloud, Docker and Kubernetes</a></b>
</p>

---

# 1. Prerequisites 📋

1. Google Cloud account
2. Google Cloud CLI installed and configured
3. Docker
4. Git

[Read more +](https://github.com/diegoulloao/ioquake3-server-gcloud/tree/main/docs/prerequisites.md)

# 2. Running in localhost 💻

Copy the `pak[0-8].pk3` dependencies into the `lib/baseq3` folder or let the script download them for you:

```bash
./prepare.sh
```

Build the Docker image:

```bash
docker build -t quake3 .
```

Run the server:

```bash
docker run -p 27960:27960/udp -it quake3
```

You should be able to find the running server in the quake3 multiplayer section.

# 3. Configuring the Server ⚙️
You can configure the server by editing the `server.cfg` file.

# 4. Deploying to Google Cloud 🌐

> Deploying to Google Cloud Kubernetes is pretty simple and fast.

Copy the `pak[0-8].pk3` dependencies into the `lib/baseq3` folder if you didn't (optional).

Copy the `.env.example` -> `.env` and fill the **projects** and **clusters** env vars taking the values from google cloud:

```bash
# project
PROJECT_ID=norse-lotus-3621XX
CONTAINER_IMAGE=quake3:latest

# cluster specific
CLUSTER=quake3-cluster-1
ZONE=us-central-1
```

[Read more +](https://github.com/diegoulloao/ioquake3-server-gcloud/tree/main/docs/env-vars.md)

Run the deploy:

```bash
./deploy.sh
```

In a couple of seconds your server should be online and ready to kick asses:

```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)           AGE
quake3   LoadBalancer   11.104.2.XXX   35.172.21.XXX   27960:32108/UDP   0s
```

# 5. Troubleshooting ⚡️

- Permission denied when running the scripts:

```bash
chmod 755 deploy.sh prepare.sh
```

---

**diegoulloao · 2022**
