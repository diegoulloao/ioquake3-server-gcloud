# q3-server

## Prepare

Fetch pk3 dependencies:

```bash
./prepare.sh
```

## Building

Build the image:

```bash
docker build -t quake3 .
```

## Running

Test in localhost:

```bash
docker run -p 27960:27960/udp -it quake3
```

## Deploy

Deploy to Google Cloud:

```bash
./deploy.sh
```
