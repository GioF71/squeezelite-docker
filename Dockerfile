from debian:buster-slim

RUN apt-get update
RUN apt-get install squeezelite -y
RUN rm -rf /var/lib/apt/lists/*

COPY run-squeezelite.sh /run-squeezelite.sh
RUN chmod u+x /run-squeezelite.sh

COPY squeezelite /etc/default

ENV SQUEEZELITE_AUDIO_DEVICE default
ENV SQUEEZELITE_NAME $(hostname -s)

ENTRYPOINT ["/run-squeezelite.sh"]
