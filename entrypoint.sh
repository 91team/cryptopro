#!/bin/bash

if [[ ! -z "${LICENSE_KEY}" ]]; then
  cpconfig -license -set $LICENSE_KEY
fi

cpconfig -license -view

csptestf -absorb -certs -autoprov

exec "$@"