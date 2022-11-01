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
        ARCH=`uname -m`; \
        mkdir /assets; \
        mkdir -p /assets/sourceforge; \
        OUTPUT_FILE=/app/bin/squeezelite; \
        OUTPUT_FILE_PULSE=/app/bin/squeezelite-pulseaudio; \
        URL_x86_64="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-x86_64.tar.gz/download"; \
        URL_aarch64="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1392-aarch64.tar.gz/download"; \
        URL_armv7l="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-1.9.9.1411-armhf.tar.gz/download"; \
        URL_x86_64_PULSE="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1392-x86_64.tar.gz/download"; \
        URL_aarch64_PULSE="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1392-aarch64.tar.gz/download"; \
        URL_armv7l_PULSE="https://sourceforge.net/projects/lmsclients/files/squeezelite/linux/squeezelite-pulse-1.9.9.1392-armhf.tar.gz/download"; \
        echo $ARCH; \
        SL_URL=""; \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get upgrade -y; \
        apt-get install wget -y; \
        apt-get install libasound2 --no-install-recommends -y; \
        apt-get install pulseaudio --no-install-recommends -y; \
        if [ "$ARCH" == "armv7l" ]; then \
            SL_URL=$URL_armv7l; \
            SL_URL_PULSE=$URL_armv7l_PULSE; \
        elif [ "$ARCH" == "x86_64" ]; then \
            SL_URL=$URL_x86_64; \
            SL_URL_PULSE=$URL_x86_64_PULSE; \
        elif [ "$ARCH" == "aarch64" ]; then \
            SL_URL=$URL_aarch64; \
            SL_URL_PULSE=$URL_aarch64_PULSE; \
        else \
            echo "Unsupported platform ["$ARCH"]"; \
        fi && \
        echo "Downloading for architecture [$ARCH]"; \
        wget $SL_URL -O /assets/sourceforge/squeezelite.tar.gz; \
        mkdir /assets/sourceforge/expanded; \
        tar xzvf /assets/sourceforge/squeezelite.tar.gz -C /assets/sourceforge/expanded; \
        ls -la /assets/sourceforge/expanded/; \
        mv /assets/sourceforge/expanded/squeezelite $OUTPUT_FILE; \
        wget $SL_URL_PULSE -O /assets/sourceforge/squeezelite-pulse.tar.gz; \
        mkdir /assets/sourceforge/expanded-pulse; \
        tar xzvf /assets/sourceforge/squeezelite-pulse.tar.gz -C /assets/sourceforge/expanded-pulse; \
        ls -la /assets/sourceforge/expanded-pulse/; \
        mv /assets/sourceforge/expanded-pulse/squeezelite $OUTPUT_FILE_PULSE; \
        apt-get purge wget -y; \
        apt-get autoremove -y; \
        rm -Rf \"/var/lib/apt/lists/*\"; \
        rm -Rf /assets; \
    else \
        apt-get update; \
        DEBIAN_FRONTEND=noninteractive apt-get upgrade -y; \
        apt-get install squeezelite --no-install-recommends -y; \
        cp /usr/bin/squeezelite /app/bin/squeezelite; \
        apt-get install squeezelite-pulseaudio --no-install-recommends -y; \
        cp /usr/bin/squeezelite-pulseaudio /app/bin/squeezelite-pulseaudio; \
        apt-get install pulseaudio --no-install-recommends -y; \
        apt-get remove squeezelite* -y; \
        rm -rf \"/var/lib/apt/lists/*\"; \
    fi'

