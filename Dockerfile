from debian:buster

RUN apt-get update
RUN apt-get install squeezelite -y
RUN rm -rf /var/lib/apt/lists/*

COPY run-squeezelite.sh /run-squeezelite.sh
COPY run-squeezelite.sh /run-presets.sh
RUN chmod u+x /run-squeezelite.sh
RUN chmod u+x /run-presets.sh

ENV SQUEEZELITE_AUDIO_DEVICE default
ENV SQUEEZELITE_NAME SqueezeLite
ENV SQUEEZELITE_TIMEOUT 2
ENV SQUEEZELITE_DELAY 500

ENV STARTUP_DELAY_SEC 0

ENV SQUEEZELITE_SERVER_PORT ""

ENV SQUEEZELITE_RATES ""
ENV SQUEEZELITE_UPSAMPLING ""

ENV PRESET ""

ENTRYPOINT ["/run-squeezelite.sh"]
