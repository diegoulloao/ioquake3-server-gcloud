<p align="right">
  <img src="https://img.shields.io/badge/ioquake3-server-red?style=for-the-badge" />
</p>

<p align="center">
  <img src="https://github.com/diegoulloao/ioquake3-mac-install/raw/master/logo.png" alt="ioQuake3 Arena" width="560"/>
</p>

---

<p align="center">
  <b><a href="https://github.com/diegoulloao/ioquake3-server-gcloud">The fastest way to create your own quake3 server using Docker, Kubernetes and Google Cloud</a></b>
</p>

---

# Prerequisites 📋

1. Google Cloud account
2. Google Cloud CLI installed, configured and linked to your account
3. Docker
4. Git

<!-- [Read more +](https://github.com/diegoulloao/ioquake3-server-gcloud/tree/main/docs/prerequisites.md) -->

# 1. Add the environment variables

Copy the `.env.example -> .env` and fill the environment variables for **projects** and **clusters** by taking the values from your google cloud account:

```bash
# project
PROJECT_ID=norse-lotus-3621XX
CONTAINER_IMAGE=quake3:latest

# cluster specific
CLUSTER=quake3-cluster-1
ZONE=us-central-1
```

# 2. Configure the Server ⚙️

You can customize the server by editing the `server.cfg` file.

**This step is not necessary**, the repository comes with a ready-made server configuration.

> [!NOTE]
> You will need to rebuild the docker container every time your `server.cnf` file changes

# 3. Q3 server to Google Cloud

**Get your server ready to play in 1 command:**

```bash
./q3s create:remote
```

**This will:**

1. add permissions to all scripts
2. download all pk3 files
3. build the docker container
4. run the docker container
5. create the google cloud cluster in your account
6. deploy the container to your google cloud cluster

**After a couple of seconds your server should be online and ready to play:**

```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)           AGE
quake3   LoadBalancer   11.104.2.XXX   35.172.21.XXX   27960:32108/UDP   0s
```

> [!NOTE]
> Your Google Cloud CLI need to be properly linked to your account

# 4. Run server on localhost

Please follow the steps `1-4` described in the next section.

Or just run manually:

```bash
# give permissions to all scripts (if you did not)
chmod +x ./scripts/*.sh

# copy the pk3 files into the baseq3 folder or download them automatically by running
./scripts/prepare.sh # or ./q3s prepare

# build the docker image
docker build -t quake3 . # or ./q3s build

# run the docker container locally
docker run -p 27960:27960/udp -it quake3 # or ./q3s start
```

After this process, you should be able to connect to your local server from the multiplayer section in your client quake3.

# 5. Build and deploy manually 💻

In order to have more control during the building and deployment process, you can take the following steps:

1. Add permissions to the main script

```bash
chmod +x q3s
```

2. Copy the `pak[0-8].pk3` dependencies into the `lib/baseq3` folder or let the script download them for you:

```bash
./q3s prepare
```

3. Build the Docker image:

```bash
./q3s build
```

4. Run the server in a container:

```bash
./q3s start
```

5. Create Google Cloud cluster

```bash
./q3s create:cluster
```

6. Deploy the container to the cluster

```bash
./q3s deploy
```

# 6. Erase server from Google Cloud

To erase your server completely, run the following command:

```bash
./q3s delete:remote
```

> [!WARNING]
> This will permanently erase your cluster, forever. You can not revert this process.

This works very well when you want to prevent your server from incurring increased costs on Google Cloud. No cost will be generated because your server will be completely erased.

You can play with the `create:remote` and `delete:remote` commands for only have your server live when you are using it.

# 7. Considerations 🔶

**All deployments to Google Cloud Kubernetes will trigger changes only if a new commit is detected in the repository.**

The deploy system provided here uses the latest commit hash in order to identify changes in the environment and tell to Kubernetes that the container must be re-deployed.

If you want to force the deploy without commit your changes, you can run:

```bash
./q3s deploy:force
```

Internally, this will run the deploy script using the `-a` flag which means `allow-empty`.

In this case, the deploy system will use a timestamp as hash in order to cause changes in the environment allowing deploy as normal.

# 8. Troubleshooting ⚡️

- Permission denied when running the scripts:

```bash
# for the main script
chmod +x q3s

# for the task scripts
chmod +x ./scripts/*.sh
```

---

**diegoulloao · 2023**
