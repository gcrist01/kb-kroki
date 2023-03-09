## Hacvk to make this setup work with zscaler

DOCKER_BUILDKIT=0 docker build -f Dockerfile.certs . -t kb-alpine-certs:3.16


## Modify other dockerimages 

will need to copy 
/etc/ssl/certs/ca-certificates.crt
from the multistage layer kb-alpine-certs:3.16
