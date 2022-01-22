#!/bin/bash

echo "Downloading from SourceForge"

apt-get install libasound2 -y
#apt-get install wget -y

mkdir -p /app/download

THE_ARCH=`/bin/bash -c 'uname -m'`
echo "THE_ARCH=["$THE_ARCH"]"

/bin/bash -c 'set -ex && \
   ARCH=`uname -m` && \
   OUTPUT_FILE=/app/download/squeezelite.tar.gz && \
   echo $ARCH && \
   if [ "$ARCH" == "armv7l" ]; then \
     cp /assets/sourceforge/*armhf*tar.gz $OUTPUT_FILE; \
   elif [ "$ARCH" == "x86_64" ]; then \
     cp /assets/sourceforge/*x86_64*tar.gz $OUTPUT_FILE; \
   elif [ "$ARCH" == "aarch64" ]; then \
     cp /assets/sourceforge/*aarch64*tar.gz $OUTPUT_FILE; \
   else \
     echo "Unsupported platform ["$ARCH"]"; \
   fi'

cd /app/download

ls -la
tar -xvzf squeezelite.tar.gz
ls -la

mkdir /app/bin
mv /app/download/squeezelite /usr/bin/squeezelite
#ln -s /app/bin/squeezelite /usr/bin/squeezelite

rm /app/download -Rf

## test binary
/usr/bin/squeezelite -?


chmod 755 /usr/bin/squeezelite

ls -la /usr/bin/squeezelite
#apt purge wget -y
