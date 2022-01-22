ARG BASE_IMAGE
ARG DOWNLOAD_FROM_SOURCEFORGE

FROM $BASE_IMAGE

#RUN echo $DOWNLOAD_FROM_SOURCEFORGE

RUN apt-get update

#RUN echo "AFTER apt-get update"

#RUN echo $DOWNLOAD_FROM_SOURCEFORGE
#RUN echo "Download from SourceForge ["$DOWNLOAD_FROM_SOURCEFORGE"]"
#RUN echo "BEFORE COPY INSTALL"
RUN mkdir /install

COPY install/sl_repo_install.sh /install
COPY install/sl_sourceforge_download.sh /install
RUN chmod u+x /install/*

#RUN echo "DOWNLOAD_FROM_SOURCEFORGE =["${DOWNLOAD_FROM_SOURCEFORGE}"]"
#RUN if [ "$DOWNLOAD_FROM_SOURCEFORGE" == "Y" ]; then \
RUN /bin/bash -c 'if [[ -z "${DOWNLOAD_FROM_SOURCEFORGE}" || "${DOWNLOAD_FROM_SOURCEFORGE}" == "Y" ]]; then \
   /install/sl_sourceforge_download.sh; \
else \
    /install/sl_repo_install.sh; \
fi'

#RUN apt-get install squeezelite -y

## test binary in both cases
RUN /usr/bin/squeezelite -?

RUN rm -rf /var/lib/apt/lists/*
RUN rm -Rf /install

COPY run-squeezelite.sh /run-squeezelite.sh
COPY run-presets.sh /run-presets.sh
RUN chmod u+x /run-squeezelite.sh
RUN chmod u+x /run-presets.sh

ENV SQUEEZELITE_AUDIO_DEVICE ""
ENV SQUEEZELITE_MIXER_DEVICE ""
ENV SQUEEZELITE_MAC_ADDRESS ""
ENV SQUEEZELITE_NAME ""
ENV SQUEEZELITE_MODEL_NAME ""
ENV SQUEEZELITE_TIMEOUT 2
ENV SQUEEZELITE_DELAY 500

ENV STARTUP_DELAY_SEC 0

ENV SQUEEZELITE_SERVER_PORT ""

ENV SQUEEZELITE_RATES ""
ENV SQUEEZELITE_UPSAMPLING ""

ENV PRESET ""

ENV SQUEEZELITE_PARAMS ""
ENV SQUEEZELITE_CODECS ""
ENV SQUEEZELITE_PRIORITY ""
ENV SQUEEZELITE_STREAM_AND_OUTPUT_BUFFER_SIZE ""

WORKDIR /

ENTRYPOINT ["/run-squeezelite.sh"]
