FROM ubuntu:16.04
MAINTAINER hotio

ARG DEBIAN_FRONTEND=noninteractive
ENV XDG_CONFIG_HOME="/config" \
    XDG_DATA_HOME="/config"
ENV LANG='C.UTF-8' LANGUAGE='C.UTF-8' LC_ALL='C.UTF-8'

# install packages
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | tee /etc/apt/sources.list.d/mono-official.list && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
        --no-install-recommends \
        --no-install-suggests \
        jq \
        curl \
        libcurl4-openssl-dev \
        ca-certificates-mono \
        mono-devel \
        sqlite3 \
        python \
        bzip2 \
        xz-utils \
        unrar \
        unzip \
        zip \
        p7zip-full \
        mediainfo && \

# install s6-overlay
    curl -s -o /tmp/s6-overlay.tar.gz -L "https://github.com/just-containers/s6-overlay/releases/download/v1.19.1.1/s6-overlay-amd64.tar.gz" && \
    tar xzf /tmp/s6-overlay.tar.gz -C / && \

# create user
    useradd -u 1000 -U -d /config -s /bin/false hotio && \
    usermod -G users hotio && \

# make folders
    mkdir -p \
	    /app \
	    /config && \

# clean up
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8080
VOLUME ["/config"]

ENTRYPOINT ["/init"]

HEALTHCHECK --interval=200s --timeout=100s CMD curl --fail http://localhost:8080 || exit 1
