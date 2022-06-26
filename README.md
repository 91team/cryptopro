# CryptoPRO CSP 5.0

## Build

- Put CryptoPRO CSP 5.0 deb package to `dist/linux-amd64_deb.tgz` path

- Build image `docker build -t registry.91.team/cryptopro/csp:latest .`

## Run

```
docker run --rm -it \
    -v "$(pwd)/keys:/var/opt/cprocsp/keys/root/cont1" \
    -e "LICENSE_KEY=40406-A0000-0219M-Q778D-1Y222" \
    registry.91.team/cryptopro/csp:latest
```

## Push to registry

`docker push registry.91.team/cryptopro/csp:latest`

## Usage

List containers:

`csptestf -keys -enum -verifyc -fqcn`

List certs:

`certmgr -list`

Sign data:

```
cryptcp \
  -signf \
  -cert \
  -detached \
  -nochain \
  -thumbprint bc47e3bdb7b19b9122df674b49f4b51148209324 \
  -pin 11111111 \
  -dir ./ ./sign_test.txt
```