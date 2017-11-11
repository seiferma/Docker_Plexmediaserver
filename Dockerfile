FROM debian:stable-slim

WORKDIR /plex

ENV DATA_VOLUME=/var/lib/plexmediaserver

RUN VERSION=1.9.6.4429-23901a099 && \
    apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.plex.tv/plex-media-server/${VERSION}/plexmediaserver_${VERSION}_amd64.deb -O plexmediaserver.deb && \
    dpkg -i plexmediaserver.deb && \
    rm -rf ${DATA_VOLUME} && \
    rm -f plexmediaserver.deb && \
    apt-get purge -y wget && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf /var/tmp/* && \
    VERSION=

RUN NEWUSER=plexserver && \
    useradd -s /bin/false -d /plex ${NEWUSER} && \
    chown ${NEWUSER}:${NEWUSER} -R ./ && \
    mkdir -p ${DATA_VOLUME} && \
    chown ${NEWUSER}:${NEWUSER} -R ${DATA_VOLUME} && \
    NEWUSER=

USER plexserver
VOLUME [${DATA_VOLUME}]

COPY ["start.sh", "./"]

ENTRYPOINT ["./start.sh"]