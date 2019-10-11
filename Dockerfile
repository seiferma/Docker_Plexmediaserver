FROM debian:stable-slim

WORKDIR /plex

EXPOSE 32400
EXPOSE 1900/udp
EXPOSE 32469

ENV PLEX_HOME=/plex/Library

RUN VERSION=1.18.0.1913-e5cc93306 && \
    apt-get update && \
    apt-get install -y wget && \
    wget https://downloads.plex.tv/plex-media-server-new/${VERSION}/debian/plexmediaserver_${VERSION}_amd64.deb -O plexmediaserver.deb && \
    dpkg -i plexmediaserver.deb && \
    rm -rf ${PLEX_HOME} && \
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
    mkdir -p ${PLEX_HOME} && \
    chown ${NEWUSER}:${NEWUSER} -R ${PLEX_HOME} && \
    NEWUSER=

USER plexserver
VOLUME ["${PLEX_HOME}"]

COPY ["start.sh", "Preferences.xml", "./"]

ENTRYPOINT ["./start.sh"]
