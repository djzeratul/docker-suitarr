[![](https://images.microbadger.com/badges/image/hotio/suitarr.svg)](https://microbadger.com/images/hotio/suitarr "Get your own image badge on microbadger.com")

## What is Suitarr?

Suitarr is one docker image that can run Radarr, Sonarr, Jackett and NZBHydra. By using the environment variable `-e APP=......`, the supported application will be downloaded and installed when starting the container.
This requires a lot less building of the images and all you need to do if you want to update the application is restart the container.

## Starting the container

#### Radarr

```
docker run --rm \
           --name radarr \
           -p 7878:8080 \
           -e APP=radarr \
           -e PUID=1000 \
           -e PGID=1000 \
           -e UMASK=022 \
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/movies:/movies \
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
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           -v /<local_path>/downloads:/downloads \
           -v /<local_path>/tvshows:/tvshows \
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
           -v /etc/localtime:/etc/localtime:ro \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

## Installing a different version

By default the latest version is installed, stable/nightly depending on the app.

- Radarr: Latest GitHub branch:develop (aka nightly)
- Sonarr: Latest GitHub branch:master (aka stable)
- Jackett: Latest GitHub branch:master (aka nightly)
- NZBHydra: Latest GitHub branch:master (aka stable)

If you prefer to install a fixed version, you can do so, by using the following environment variables:

```
# Radarr
-e VERSION=0.2.0.307

# Sonarr
-e BRANCH=develop
-e VERSION=2.0.0.4578

# Jackett
-e VERSION=0.7.1001

# NZBHydra
-e VERSION=f60a628cc5d2a17677e6c9b6bb12ad41063ea4e0
```

## In case of problems

When the auto installation of the app fails for whatever reason, you can provide the installation files manually by mounting the file as a volume.
Or if you are modifying/self-compiling any app, you can use this feature to test your version. All files should be in a `tar.gz` file.

```
-v /<local_path>/Radarr.develop.0.2.0.817.linux.tar.gz:/app.tar.gz
-v /<local_path>/NzbDrone.master.tar.gz:/app.tar.gz
...
```

## Additional environment variables

You can use the following additional environment variables for certain apps.

```
-e JACKETT_PROXY=...
```
