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

# 1. Add environment variables 💎

Copy the `.env.example -> .env` and fill the environment variables for the **project** and **cluster** sections by taking the `project-id` from your google cloud account.

> [!NOTE]
> Is not necessary to create the cluster, the script will do it for you given the zone

```bash
# project
PROJECT_ID=norse-lotus-3621XX
CONTAINER_IMAGE=quake3:latest

# cluster specific
CLUSTER=quake3-cluster-1
ZONE=us-central1
```

[Read about cluster zones +](https://cloud.google.com/compute/docs/regions-zones)

# 2. Configure the Server ⚙️

You can customize the server by editing the `server.cfg` file.

**This step is not necessary**, the repository comes with a ready-made server configuration.

> [!NOTE]
> You will need to rebuild the docker container every time your `server.cfg` file changes

# 3. Q3 server to Google Cloud 🌐

**Get your server ready to play in 1 command:**

```bash
./q3s create:remote
```

**This will:**

1. add permissions to all scripts
2. download all pk3 files
3. create the google cloud cluster in your account
4. build the docker image
5. deploy the image to your google cloud cluster

> [!IMPORTANT]
> Your Google Cloud CLI need to be properly linked to your account

**After a couple of minutes your server should be online and ready to play** 👾

---

**Run the following command to get the IP:**

```bash
./q3s ip
```

Until the `external-ip` is resolved:

```
NAME     TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)           AGE
quake3   LoadBalancer   11.104.2.XXX   35.172.21.XXX   27960:32108/UDP   0s
```

> [!NOTE]
> The connection to the server may succeed after a couple of seconds that the `external-ip` is resolved

# 4. Run server on localhost 🚀

Please follow the steps `1-3` described in the next section: [5. Build and deploy manually](#5-build-and-deploy-manually-) <small>(recommended)</small>

<details>
  <summary>Alternatively you can run each command <small>(advanced)</small></summary>

  <br />
  
  1. Give permissions to all scripts (if you did not)
  ```bash
chmod +x ./scripts/*.sh
  ```

2. Copy all pk3 files inside `lib/baseq3` or let the script download them for you

```bash
./scripts/prepare.sh
```

3. Build the docker image

```bash
docker build -t quake3 .
```

4. Run the docker container

```bash
docker run -p 27960:27960/udp -it quake3
```

</details>

---

**Important** 💡

You only need to do this process once, after that, you will need to rebuild the image only if changes are applied to your `server.cfg` file.

Next time you want to run your server locally just use the `./q3s start` command.

---

After the process, you should be able to connect to your local server from the multiplayer section in your client quake3.

# 5. Build and deploy manually 💻

In order to have more control during the building and/or deployment process, you can go through the following steps:

1. Copy the `pk3` dependencies into the `lib/baseq3` folder or let the script download them for you

```bash
./q3s prepare
```

2. Build the Docker image

```bash
./q3s build
```

3. Run the server in a container

```bash
./q3s start
```

**At this step you have the server running on localhost** 🚀

---

4. Create Google Cloud cluster

```bash
./q3s create:cluster
```

5. Deploy the image to the cluster

```bash
./q3s deploy
```

**Now is live on Google Cloud** 🌐

# 6. Erase server from Google Cloud ⭕

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

If you want to force the deploy without committing your changes, you can run:

```bash
./q3s deploy:force
```

Internally, this will run the deploy script using the `-a` flag which means `allow-empty`.

In this case, the deploy system will use a timestamp as hash in order to cause changes in the environment allowing deploy as normal.

# 8. Command list ❔

You can list all the commands available from your terminal by running:

```bash
./q3s help
```

**Help: commands**

```
+----------------+-----------------------------------------------------------------------------+
| command        | description                                                                 |
+================+=============================================================================+
| permissions    | give to scripts necessary permissions to run in the system                  |
+----------------+-----------------------------------------------------------------------------+
| prepare        | give permissions to the scripts and download dependencies                   |
+----------------+-----------------------------------------------------------------------------+
| build          | build docker image                                                          |
+----------------+-----------------------------------------------------------------------------+
| start          | create container and run the server in localhost                            |
+----------------+-----------------------------------------------------------------------------+
| create:cluster | create cluster in google cloud                                              |
+----------------+-----------------------------------------------------------------------------+
| deploy         | deploy the server to the cluster in google cloud                            |
+----------------+-----------------------------------------------------------------------------+
| deploy:force   | force deploy the server even when there are no new commits                  |
+----------------+-----------------------------------------------------------------------------+
| create:remote  | create cluster in google cloud, download dependencies and deploy the server |
+----------------+-----------------------------------------------------------------------------+
| delete:remote  | deletes the cluster from google cloud                                       |
+----------------+-----------------------------------------------------------------------------+
| ip             | displays the server public ip                                               |
+----------------+-----------------------------------------------------------------------------+
```

# 9. Troubleshooting ⚡️

- Permission denied when running the scripts:

```bash
# for the main script
chmod +x q3s

# for the task scripts
chmod +x ./scripts/*.sh
```

---

**diegoulloao · 2024**
