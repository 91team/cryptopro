FROM debian:buster-slim

ENV TZ="Europe/Moscow" \
  docker="1"

ADD dist /tmp/src

RUN apt-get update && apt-get install -y \
  lsb-base && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  cd /tmp/src && \
  tar -xf linux-amd64_deb.tgz && \
  linux-amd64_deb/install.sh && \
  cd /bin && \
  ln -s /opt/cprocsp/bin/amd64/certmgr && \
  ln -s /opt/cprocsp/bin/amd64/cpverify && \
  ln -s /opt/cprocsp/bin/amd64/cryptcp && \
  ln -s /opt/cprocsp/bin/amd64/csptest && \
  ln -s /opt/cprocsp/bin/amd64/csptestf && \
  ln -s /opt/cprocsp/bin/amd64/der2xer && \
  ln -s /opt/cprocsp/bin/amd64/inittst && \
  ln -s /opt/cprocsp/bin/amd64/wipefile && \
  ln -s /opt/cprocsp/sbin/amd64/cpconfig && \
  rm -rf /tmp/src

VOLUME [ "/var/opt/cprocsp/keys" ]

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]