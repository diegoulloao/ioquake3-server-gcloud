# install ubuntu + ioquake3
FROM ubuntu:latest
RUN apt-get update && apt-get install -y ioquake3 ioquake3-server

# establish workdir
WORKDIR /usr/lib/ioquake3

# copy baseq3 dependencies
COPY lib/baseq3 baseq3

# copy config file
COPY server.cfg baseq3

# system user
RUN adduser --disabled-password q3user_svc
USER q3user_svc

# exec server
ENTRYPOINT ["/usr/lib/ioquake3/ioq3ded", "+exec"]
CMD ["server.cfg"]
