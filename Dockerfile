FROM debian:buster-slim

ENV TZ="Europe/Moscow" \
  docker="1" \
  LC_ALL="ru_RU.UTF-8" \
  LANG="ru_RU.UTF-8" \
  LANGUAGE="ru_RU.UTF-8"

ADD dist /tmp/src

RUN apt-get update && apt-get install -y \
  locales-all \
  lsb-base && \
  ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
  echo $TZ > /etc/timezone && \
  cd /tmp/src && \
  tar -xf linux-amd64_deb.tgz && \
  linux-amd64_deb/install.sh cprocsp-nginx && \
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
  ln -s /opt/cprocsp/sbin/amd64/cpnginx && \
  certmgr -inst -file /tmp/src/cert/rsa/test.91.gost.dev.pem && \
  rm -rf /tmp/src

VOLUME [ "/var/opt/cprocsp/keys" ]

COPY nginx.conf /etc/opt/cprocsp/cpnginx/conf.d/default.conf 
COPY cpnginx.conf /etc/opt/cprocsp/cpnginx/cpnginx.conf
COPY index.html /var/opt/cprocsp/cpnginx/html/index.html

COPY header.key /var/opt/cprocsp/keys/root/srv.000/header.key
COPY masks.key /var/opt/cprocsp/keys/root/srv.000/masks.key
COPY masks2.key /var/opt/cprocsp/keys/root/srv.000/masks2.key
COPY name.key /var/opt/cprocsp/keys/root/srv.000/name.key
COPY primary.key /var/opt/cprocsp/keys/root/srv.000/primary.key
COPY primary2.key /var/opt/cprocsp/keys/root/srv.000/primary2.key

EXPOSE 443/tcp


COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]