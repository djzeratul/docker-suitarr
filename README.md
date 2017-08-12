[![](https://images.microbadger.com/badges/image/hotio/suitarr.svg)](https://microbadger.com/images/hotio/suitarr "Get your own image badge on microbadger.com")

## What is Suitarr?

Suitarr is one docker image that can run Radarr, Sonarr, Jackett and NZBHydra. By using the flag `-e APP=......`, the supported application will be downloaded and installed when starting the container.
This requires a lot less building of the images and all you need to do if you want to update the application is restart the container.

## Starting the container

#### Radarr

```
docker run --rm \
           --name radarr \
           -p 7878:8080 \
           -e APP=radarr \
           -e UMASK=022 \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
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
           -e UMASK=022 \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
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
           -e UMASK=022 \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

#### NZBHydra

```
docker run --rm \
           --name nzbhydra \
           -p 5075:8080 \
           -e APP=nzbhydra \
           -e UMASK=022 \
           -e PUID=1000 -e PGID=1000 \
           -e TZ=America/New_York \
           -v /<local_path>/config:/config \
           hotio/suitarr
```

## Installing a different version

By default the latest version is installed, stable/nightly depending on the app.

- Radarr: Latest GitHub branch:develop (aka nightly)
- Sonarr: Latest GitHub branch:master (aka stable)
- Jackett: Latest GitHub branch:master (aka nightly)
- NZBHydra: Latest GitHub branch:master (aka stable)

If you prefer to install a fixed version, you can do so, by using the following tags:

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
