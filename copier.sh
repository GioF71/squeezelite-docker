#!/bin/bash

/bin/bash -c 'set -ex && \
   ARCH=`uname -m` && \
   OUTPUT_FILE=/usr/bin/squeezelite && \
   echo $ARCH && \
   if [ "$ARCH" == "armv7l" ]; then \
     mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   elif [ "$ARCH" == "x86_64" ]; then \
     mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   elif [ "$ARCH" == "aarch64" ]; then \
     mv /assets/sourceforge/$ARCH/squeezelite $OUTPUT_FILE; \
   else \
     echo "Unsupported platform ["$ARCH"]"; \
   fi'
