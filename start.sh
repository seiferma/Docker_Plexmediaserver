#!/bin/sh

SCRIPT_FILE=$(readlink -f "$0")
SCRIPT_DIR=$(dirname "$SCRIPT_FILE")

PREF_DIR=$PLEX_HOME/Application\ Support/Plex\ Media\ Server
PREF_FILE=Preferences.xml
if [ ! -f "$PREF_DIR/$PREF_FILE" ]; then
    echo Initializing preferences.
    mkdir -p "$PREF_DIR"
    cp $SCRIPT_DIR/Preferences.xml "$PREF_DIR/$PREF_FILE"
fi
LD_LIBRARY_PATH=/usr/lib/plexmediaserver "/usr/lib/plexmediaserver/Plex Media Server"
