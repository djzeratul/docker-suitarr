[![Docker Build Statu](https://img.shields.io/docker/build/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Automated buil](https://img.shields.io/docker/automated/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Docker Stars](https://img.shields.io/docker/stars/hotio/suitarr.svg?style=flat-square)](https://hub.docker.com/r/hotio/suitarr)
[![Maintenance](https://img.shields.io/maintenance/yes/2017.svg?style=flat-square)](https://github.com/hotio/docker-suitarr)

```
    _________      __  __
   /   _____/__ __|__|/  |______ ______________
   \_____  \|  |  \  \   __\__  \\_  __ \_  __ \
   /        \  |  /  ||  |  / __ \|  | \/|  | \/
  /_______  /____/|__||__| (____  /__|   |__|
          \/                    \/
```

## What is Suitarr?

Suitarr is one docker image that can run Radarr, Sonarr, Jackett and NZBHydra. By using the environment variable `-e APP=......`, the supported application will be downloaded and installed when starting the container.
This requires a lot less building of the images and all you need to do if you want to update the application is restart the container.

## Starting the container

The environment variables `PUID`, `PGID`, `UMASK`, `VERSION` and `BACKUP` are all optional, the values you see below are the default values.

#### Radarr

```
docker run --rm \
           --name radarr \
           -p 7878:8080 \
           -e APP=radarr \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### Sonarr

```
docker run --rm \
           --name sonarr \
           -p 8989:8080 \
           -e APP=sonarr \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### Jackett

```
docker run --rm \
           --name jackett \
           -p 9117:8080 \
           -e APP=jackett \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### NZBHydra

```
docker run --rm \
           --name nzbhydra \
           -p 5075:8080 \
           -e APP=nzbhydra \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### NZBGet

```
docker run --rm \
           --name nzbget \
           -p 6789:8080 \
           -e APP=nzbget \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### SABnzbd

```
docker run --rm \
           --name sabnzbd \
           -p 8080:8080 \
           -e APP=sabnzbd \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -e VERSION=stable \
           -e BACKUP=yes \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

## Installing a different version

By default the latest stable version is installed. You can however change this behaviour with the environment variable `VERSION`.
The value `unstable` will install the latest unstable version, using a version number like `0.2.0.307` as a value, installs the specified version.
When given an absolute path like `/config/Radarr.develop.0.2.0.817.linux.tar.gz`, installs that local file.

#### Radarr

```
-e VERSION=unstable
-e VERSION=0.2.0.307
-e VERSION=/config/Radarr.develop.0.2.0.817.linux.tar.gz
```

#### Sonarr

```
-e VERSION=unstable
-e VERSION=2.0.0.4578
-e VERSION=/config/NzbDrone.develop.tar.gz
```

#### Jackett

```
-e VERSION=unstable
-e VERSION=0.7.1001
-e VERSION=/config/Jackett.Binaries.Mono.tar.gz
```

#### NZBHydra

```
-e VERSION=unstable
-e VERSION=f60a628cc5d2a17677e6c9b6bb12ad41063ea4e0
-e VERSION=/config/0.2.226.tar.gz
```

#### NZBGet

```
-e VERSION=unstable
-e VERSION=19.1-r2031
-e VERSION=/config/nzbget-19.1-bin-linux.run
```

#### SABnzbd

```
-e VERSION=unstable
-e VERSION=2.2.1RC2
-e VERSION=/config/SABnzbd-2.2.1-src.tar.gz
```

## Backing up the configuration

By default on every docker container shutdown a backup is created from the configuration files, in the same manner as the apps do on their own.
To disable this, use `-e BACKUP=no`.

## Additional app arguments

You can use the following environment variable to pass on additional arguments to your app.

```
-e ARGS="--ProxyConnection localhost:8118"
```
