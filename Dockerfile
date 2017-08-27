FROM ubuntu:17.04
MAINTAINER hotio

ARG DEBIAN_FRONTEND=noninteractive
ENV XDG_CONFIG_HOME="/config" XDG_DATA_HOME="/config"
ENV LANG='C.UTF-8' LANGUAGE='C.UTF-8' LC_ALL='C.UTF-8'

# install packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 98703123E0F52B2BE16D586EF13930B14BB9F05F && echo "deb http://ppa.launchpad.net/jcfp/sab-addons/ubuntu zesty main" | tee /etc/apt/sources.list.d/sab-addons.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends --no-install-suggests \
        jq \
        curl \
        libcurl4-openssl-dev \
        ca-certificates-mono \
        mono-devel \
        sqlite3 \
        python \
        python-cheetah \
        python-sabyenc \
        python-cryptography \
        par2-tbb \
        bzip2 \
        xz-utils \
        unrar \
        unzip \
        zip \
        p7zip-full \
        mediainfo && \

# install s6-overlay
    curl -s -o - -L "https://github.com/just-containers/s6-overlay/releases/download/v1.20.0.0/s6-overlay-amd64.tar.gz" | tar xzf - -C / && \

# make folders
    mkdir -p /app /config && \

# create user
    useradd -u 1000 -U -d /config -s /bin/false hotio && \
    usermod -G users hotio && \

# clean up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /

EXPOSE 8080

VOLUME ["/config"]

ENTRYPOINT ["/init"]

HEALTHCHECK --interval=200s --timeout=100s CMD curl --fail http://localhost:8080 || exit 1
