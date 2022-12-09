# install ubuntu + ioquake3
FROM ubuntu:latest
RUN apt-get update && apt-get install -y ioquake3 ioquake3-server

# copy pk3 dependencies
COPY lib/baseq3/pak0.pk3 /usr/lib/ioquake3/baseq3

COPY lib/baseq3/pak1.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak2.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak3.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak4.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak5.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak6.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak7.pk3 /usr/lib/ioquake3/baseq3
COPY lib/baseq3/pak8.pk3 /usr/lib/ioquake3/baseq3

# copy config file
COPY serversetup.cfg /usr/lib/ioquake3/baseq3

# system user
RUN adduser --disabled-password q3user_svc
USER q3user_svc

# exec server
ENTRYPOINT ["/usr/lib/ioquake3/ioq3ded", "+exec"]
CMD ["serversetup.cfg"]
