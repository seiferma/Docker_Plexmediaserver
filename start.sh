#!/bin/sh

SCRIPT_FILE=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_FILE")

if [ ! -f "$PREFERENCES" ]; then
    echo Initializing preferences.
    mkdir -p $PLEX_HOME/Application\ Support/Plex\ Media\ Server
    cp $SCRIPT_DIR/Preferences.xml $PLEX_HOME/Application\ Support/Plex\ Media\ Server/Preferences.xml
fi
LD_LIBRARY_PATH=/usr/lib/plexmediaserver "/usr/lib/plexmediaserver/Plex Media Server"
