#!/bin/bash

echo ${0}
echo ${1}
export DOWNLOADED_BIN=${1}
echo $DOWNLOADED_BIN

/bin/bash -c 'set -ex && \
    ARCH=`uname -m` && \
    OUTPUT_FILE=/usr/bin/squeezelite && \
    echo $ARCH && \
    if [ "$DOWNLOADED_BIN" == "Y" ]; then \
        echo "Installing libasound2 from repositories"; \
        apt-get install libasound2 -y; \
        echo "Installing symbolic link"; \
        ln -s /app/bin/squeezelite /usr/bin/squeezelite; \
    else \
        echo "Installing from repositories"; \
        apt install squeezelite -y; \
    fi'

