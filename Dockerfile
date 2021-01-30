from debian:buster-slim

RUN apt-get update
RUN apt-get install squeezelite -y
RUN rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/run-squeezelite.sh"]
