#!/bin/bash

echo "Downloading from SourceForge"

apt-get install libasound2 -y
apt-get install wget -y

mkdir -p /app/download

/bin/bash -c 'set -ex && \
    ARCH=`uname -m` && \
    OUTPUT_FILE=/app/download/squeezelite.tar.gz && \
    echo $ARCH && \
    if [ "$ARCH" == "armv7l" ]; then \
       DL_URL="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-armhf.tar.gz/download" && \
       echo "*** Downloading ["$DL_URL"] ***" && \
       wget $DL_URL -O $OUTPUT_FILE; \
    elif [ "$ARCH" == "x86_64" ]; then \
       DL_URL="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-x86_64.tar.gz/download" && \
       wget $DL_URL -O $OUTPUT_FILE; \
    elif [ "$ARCH" == "aarch64" ]; then \
       DL_URL="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-aarch64.tar.gz/download" && \
       wget $DL_URL -O $OUTPUT_FILE; \
    else \
      echo "Unsupported platform ["$ARCH"]"; \
    fi'

cd /app/download
ls -la
tar -xvzf squeezelite.tar.gz

echo "no-cache"
ls -la

mv /app/download/squeezelite /usr/bin/squeezelite

rm /app/download -Rf

chmod 755 /usr/bin/squeezelite

ls -la /usr/bin/squeezelite
apt purge wget -y
