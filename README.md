# CryptoPRO CSP 4.0

## Build

- Put CryptoPRO CSP deb package to `dist/linux-amd64_deb.tgz` path

- Build image `docker build -t registry.91.team/cryptopro/csp:latest .`

## Run

```
docker run --rm -it \
    -v "$(pwd)/keys:/var/opt/cprocsp/keys/root" \
    -e "LICENSE_KEY=40406-A0000-0219M-Q778D-1Y222" \
    registry.91.team/cryptopro/csp:latest
```

## Push to registry

`docker push registry.91.team/cryptopro/csp:latest`
