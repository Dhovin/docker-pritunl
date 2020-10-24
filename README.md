# Pritunl + Docker + LinuxServer.io = <3

Updated to support Wiregaurd
updated to suppose mongodb 4.2

## Pull the image

    docker pull dhovin/docker-pritunl

## Run Pritunl

    docker run -d --privileged \
        -v {path}:/config \
        -p 1194:1194/udp \
        -p 1194:1194/tcp \
        -p 9700:443/tcp \
        -p 9699:80/tcp \
        -p 51820:51820/udp \
        --name Pritunl \
        dhovin/docker-pritunl

## Configure Pritunl

* Open https://`youripaddress`:9700
* Get your default creds (run on docker host via a shell): `docker exec -it Pritunl pritunl default-password`
* Fun
