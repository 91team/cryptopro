#!/bin/bash

if [[ ! -z "${LICENSE_KEY}" ]]; then
  cpconfig -license -set $LICENSE_KEY
fi

cpconfig -license -view

csptestf -absorb -certs -autoprov

certmgr -list

csptestf -keys -enum -verifyc -fqcn

cpconfig -license -view

# /etc/init.d/cprocsp start
# cpnginx -g "daemon off;"

/etc/init.d/cprocsp start && cpnginx -g "daemon off;"

exec "$@"