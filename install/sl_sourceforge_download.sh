#!/bin/bash

echo "Downloading from SourceForge"

apt-get install libasound2 -y
#apt-get install wget -y

THE_ARCH=`/bin/bash -c 'uname -m'`
echo "THE_ARCH=["$THE_ARCH"]"

/bin/bash -c 'set -ex && \
   ARCH=`uname -m` && \
   OUTPUT_FILE=/usr/bin/squeezelite && \
   echo $ARCH && \
   if [ "$ARCH" == "armv7l" ]; then \
     cp /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   elif [ "$ARCH" == "x86_64" ]; then \
     cp /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   elif [ "$ARCH" == "aarch64" ]; then \
     cp /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   else \
     echo "Unsupported platform ["$ARCH"]"; \
   fi'

## test binary
/usr/bin/squeezelite -?


chmod 755 /usr/bin/squeezelite

ls -la /usr/bin/squeezelite
#apt purge wget -y
