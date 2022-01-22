#!/bin/bash

echo ${0}
echo ${1}
export MV_BIN=${1}
echo $MV_BIN

/bin/bash -c 'set -ex && \
    ARCH=`uname -m` && \
    OUTPUT_FILE=/usr/bin/squeezelite && \
    echo $ARCH && \
    if [ "$MV_BIN" == "Y" ]; then \
        if [ "$ARCH" == "armv7l" ]; then \
            mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
        elif [ "$ARCH" == "x86_64" ]; then \
            mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
        elif [ "$ARCH" == "aarch64" ]; then \
            mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
        else \
            echo "Unsupported platform ["$ARCH"]"; \
        fi \
    else \
        echo "Nothing to download."; \
        touch /usr/bin/squeezelite; \
    fi'

