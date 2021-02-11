ARG ARCH=
from ${ARCH}debian:buster-slim

RUN apt-get update
RUN apt-get install squeezelite -y
RUN rm -rf /var/lib/apt/lists/*

COPY run-squeezelite.sh /run-squeezelite.sh
RUN chmod u+x /run-squeezelite.sh

ENV SQUEEZELITE_AUDIO_DEVICE default
ENV SQUEEZELITE_NAME SqueezeLite
ENV SQUEEZELITE_TIMEOUT 2
ENV SQUEEZELITE_DELAY 500

ENV STARTUP_DELAY_SEC 0

ENV SQUEEZELITE_SPECIFY_SERVER no
ENV SQUEEZELITE_SERVER_PORT server

ENTRYPOINT ["/run-squeezelite.sh"]
