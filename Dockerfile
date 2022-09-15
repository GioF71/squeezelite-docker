ARG BASE_IMAGE
FROM ${BASE_IMAGE}
ARG DOWNLOAD_FROM_SOURCEFORGE

ENV SQUEEZELITE_MODE ""
ENV SQUEEZELITE_AUDIO_DEVICE ""
ENV SQUEEZELITE_MIXER_DEVICE ""
ENV SQUEEZELITE_MAC_ADDRESS ""
ENV SQUEEZELITE_NAME ""
ENV SQUEEZELITE_MODEL_NAME ""
ENV SQUEEZELITE_TIMEOUT ""
ENV SQUEEZELITE_DELAY ""

ENV STARTUP_DELAY_SEC ""

ENV SQUEEZELITE_SERVER_PORT ""

ENV SQUEEZELITE_RATES ""
ENV SQUEEZELITE_UPSAMPLING ""

ENV PRESET ""

ENV SQUEEZELITE_PARAMS ""
ENV SQUEEZELITE_CODECS ""
ENV SQUEEZELITE_EXCLUDE_CODECS ""
ENV SQUEEZELITE_PRIORITY ""
ENV SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE ""
ENV SQUEEZELITE_BUFFER_SIZE ""
ENV SQUEEZELITE_UNMUTE ""
ENV SQUEEZELITE_VOLUME_CONTROL ""
ENV SQUEEZELITE_LINEAR_VOLUME ""
ENV SQUEEZELITE_VISUALIZER ""

ENV DISPLAY_PRESETS ""

RUN mkdir /app
RUN mkdir /app/bin/

RUN mkdir /install
COPY install/installer.sh /install/
RUN chmod u+x /install/*

WORKDIR /install

RUN /install/installer.sh $DOWNLOAD_FROM_SOURCEFORGE

# remove scripts
RUN rm -Rf /install

## test binary in both cases
RUN /usr/bin/squeezelite -?

COPY app/bin/run-squeezelite.sh /app/bin/run-squeezelite.sh
COPY app/bin/run-squeezelite-alsa.sh /app/bin/run-squeezelite-alsa.sh
COPY app/bin/run-squeezelite-pulse.sh /app/bin/run-squeezelite-pulse.sh
COPY app/bin/run-presets.sh /app/bin/run-presets.sh

RUN chmod u+x /app/bin/run-squeezelite.sh
RUN chmod u+x /app/bin/run-squeezelite-alsa.sh
RUN chmod u+x /app/bin/run-squeezelite-pulse.sh
RUN chmod u+x /app/bin/run-presets.sh

RUN mkdir /app/doc
RUN mkdir /app/assets

VOLUME '/app/assets/additional-presets.conf'

COPY README.md /app/doc
COPY RELEASE.md /app/doc
COPY app/assets/builtin-presets.conf /app/assets/
COPY app/assets/pulse-client-template.conf /app/assets/pulse-client-template.conf

WORKDIR /app/bin

ENTRYPOINT ["/app/bin/run-squeezelite.sh"]
